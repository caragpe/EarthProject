class AddAditonalDataToReport < ActiveRecord::Migration
  def change
    add_column :reports, :title, :string
    add_column :reports, :active, :boolean, default: false
    add_column :reports, :year, :integer
  end
end
