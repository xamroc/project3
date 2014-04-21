class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to  :user, index: true
      t.belongs_to  :tool, index: true
      t.datetime    :transaction_date
      t.datetime    :rent_date
      t.datetime    :return_date

      t.timestamps
    end
  end
end
