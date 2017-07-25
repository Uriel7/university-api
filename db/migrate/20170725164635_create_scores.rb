class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.references :student, foreign_key: true
      t.references :subject, foreign_key: true
      t.float :qualification

      t.timestamps
    end
  end
end
