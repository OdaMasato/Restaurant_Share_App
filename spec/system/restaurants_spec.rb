require 'spec_helper'


describe '飲食店一覧表示機能', type: :system do
  describe '一覧表示機能' do
    before do
      #テストユーザAを作成しておく
      user_a = FactoryBot.create(:user, name: 'ユーザA', email: 'a@example.com')
    end

    context 'ユーザAがログインしているとき' do
      before do
        #ユーザAでログインする
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end

      it '飲食店情報一覧が表示される' do
        # 飲食店情報の一覧が表示されていることを確認
        expect(page).to have_content '全席個室'
      end
    end
    
  end
end
