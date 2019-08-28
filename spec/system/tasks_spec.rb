require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      #ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      #作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
    end

    context 'ユーザAがログインしている時' do
      before do
        #ユーザーAでログインする
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成たタスクの表示' do
        #ユーザーAが作成したタスクが画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
      end

      context 'ユーザーBがログインしている時' do
        before do
          #ユーザーBを作成しておく
          FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
          #ユーザーBでログインする
          visit login_path
          fill_in 'メールアドレス', with: 'b@example.com'
          fill_in 'パスワード', with: 'password'
          click_button 'ログインする'
        end

        it 'ユーザーAが作成したタスクが作成されない' do
          #ユーザーAが作成したタスクが画面上に表示されていないことを確認
          expect(page).to have_no_content '最初のタスク'
        end
      end
    end
  end
end
