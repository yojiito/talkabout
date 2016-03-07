class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|

      t.text :title
      t.string :date
      t.text :place
      t.text :image_url
      t.text :talent
      t.text :detail
      t.timestamps 
    end
  end
end
