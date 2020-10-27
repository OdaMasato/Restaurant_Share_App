FactroyBot.define do
  factory :user do
    account_name{ 'テストユーザー'}
    account_id{ 'test1'}
    email{ 'test1@example.com'}
    password{ 'password' }
  end
end
