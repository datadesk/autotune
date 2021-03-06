require 'work_dir/base'
require 'fileutils'
require 's3deploy/deployer'
require 'uri'

module WorkDir
  # A static website
  class Website < Base
    def deploy(destination)
      url_parts = URI.parse(destination)
      send("deploy_to_#{url_parts.scheme}", destination)
    end

    def deploy_file(path, destination)
      url_parts = URI.parse(destination)
      send("deploy_file_to_#{url_parts.scheme}", path, destination)
    end

    def deploy_to_s3(url)
      url_parts = URI.parse(url)
      deployer = S3deploy::Deployer.new(
        :dist_dir => working_dir, :bucket => url_parts.host,
        :app_path => url_parts.path, :logger => Rails.logger)
      deployer.deploy!
    end

    def deploy_file_to_s3(path, url)
      url_parts = URI.parse(url)
      deployer = S3deploy::Deployer.new(
        :dist_dir => working_dir, :bucket => url_parts.host,
        :app_path => url_parts.path, :logger => Rails.logger)
      deployer.deploy_file!(path)
    end

    def deploy_to_file(url)
      url_parts = URI.parse(url)
      rm(url_parts.path) if File.exist?(url_parts.path)
      copy_to(url_parts.path)
    end

    def deploy_file_to_file(path, url)
      url_parts = URI.parse(url)
      cp(path, File.join(url_parts.path, path))
    end
  end
end
