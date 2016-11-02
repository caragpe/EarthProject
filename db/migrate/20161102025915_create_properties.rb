class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string    :property_name
      t.text      :description
      t.integer   :owner_id
      t.float     :value
      t.datetime  :created_at
      t.datetime  :updated_at  
    end
  end
end
