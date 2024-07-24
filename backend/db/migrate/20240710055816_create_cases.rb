class CreateCases < ActiveRecord::Migration[7.2]
  def change
    create_table :cases do |t|
      t.string :messagingSection
      t.string :phoneNumber
      t.string :topic
      t.integer :status
      t.belongs_to :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
