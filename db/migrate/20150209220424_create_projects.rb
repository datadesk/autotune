class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :slug, :index => true
      t.string :title
      t.string :status
      t.string :blueprint_version
      t.text :data
      t.text :output
      t.references :blueprint, :index => true

      t.timestamps :null => false
    end
    add_foreign_key :projects, :blueprints
  end
end