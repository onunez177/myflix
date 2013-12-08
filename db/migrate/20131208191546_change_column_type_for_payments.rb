class ChangeColumnTypeForPayments < ActiveRecord::Migration
  def change
    change_column :payments, :reference_id, :string
  end
end
