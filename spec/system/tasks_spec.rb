require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}

    before do
      # #ユーザーAを作成しておく
      # user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      #作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)

      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'
    end

    context 'ユーザAがログインしている時' do
      let(:login_user) {user_a}

      it 'ユーザーAが作成たタスクの表示' do
          #ユーザーAが作成したタスクが画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
      end
    end

      context 'ユーザーBがログインしている時' do
        let(:login_user) {user_b}
        # before do
        #   #ユーザーBを作成しておく
        #   FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')
          #ユーザーBでログインする
          # visit login_path
          # fill_in 'メールアドレス', with: 'b@example.com'
          # fill_in 'パスワード', with: 'password'
          # click_button 'ログインする'

        it 'ユーザーAが作成したタスクが作成されない' do
          #ユーザーAが作成したタスクが画面上に表示されていないことを確認
          expect(page).to have_no_content '最初のタスク'
        end
      end
    end
  end
