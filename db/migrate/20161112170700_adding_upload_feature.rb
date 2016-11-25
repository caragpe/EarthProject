class AddingUploadFeature < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :filename
      t.string :content_type
      t.binary :file_contents
      t.integer :property_id

      t.timestamps
    end
  end
end