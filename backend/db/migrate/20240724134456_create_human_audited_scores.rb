class CreateHumanAuditedScores < ActiveRecord::Migration[7.2]
  def change
    create_table :human_audited_scores do |t|
      t.boolean :huScore1
      t.boolean :huScore2
      t.boolean :huScore3
      t.boolean :huScore4
      t.boolean :huScore5
      t.boolean :huScore6
      t.boolean :huScore7
      t.boolean :huScore8
      t.boolean :huScore9
      t.string :huFeedback
      t.float :huTotalScore
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :ai_audited_score, null: false, foreign_key: true

      t.timestamps
    end
  end
end
