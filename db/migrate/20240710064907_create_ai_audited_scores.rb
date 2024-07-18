class CreateAiAuditedScores < ActiveRecord::Migration[7.2]
  def change
    create_table :ai_audited_scores do |t|
      t.boolean :aiScore1
      t.boolean :aiScore2
      t.boolean :aiScore3
      t.boolean :aiScore4
      t.boolean :aiScore5
      t.boolean :aiScore6
      t.boolean :aiScore7
      t.boolean :aiScore8
      t.boolean :aiScore9
      t.string :aiFeedback
      t.float :totalScore
      t.boolean :isMadeCorrection
      t.belongs_to :case, null: false, foreign_key: true

      t.timestamps
    end
  end
end
