require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
    let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a)}

  before do
    # #ユーザーAを作成しておく
    # user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
    #作成者がユーザーAであるタスクを作成しておく
    # FactoryBot.create(:task, name: '最初のタスク', user: user_a)
  visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

    shared_examples_for 'ユーザーAが作成したタスクが表示される' do
      it { expect(page).to have_content '最初のタスク'}
    end

    describe '一覧表示機能' do
      context 'ユーザAがログインしている時' do
        let(:login_user) {user_a}

        it_behaves_like 'ユーザーAが作成したタスクが表示される'
      end


      context 'ユーザーBがログインしている時' do
        let(:login_user) {user_b}

        it 'ユーザーAが作成したタスクが表示されない' do
          expect(page).to have_no_content '最初のタスク'
        end
      end
    end

    describe '詳細表示機能' do
      context 'ユーザーAがログインしている時' do
        let(:login_user) { user_a }

        before do
          visit task_path(task_a)
        end

        it_behaves_like 'ユーザーAが作成したタスクが表示される'
      end
    end
  end
end
# require 'rails_helper'
#
# describe 'タスク管理機能', type: :system do
#   # ユーザーの作成
#   let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
#   let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
#   let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a) }
#
#
#   before do
#     # ログイン処理
#     # - セッションが絡んでいるせいなのか、fill_in 'メールアドレス'だと通らない・・・
#     # TODO これを下で呼び出す仕組みが不明・・・遅延評価？
#     visit login_path
#     fill_in 'session[email]', with: login_user.email
#     fill_in 'session[password]', with: login_user.password
#     click_button 'ログイン'
#   end
#
#   shared_examples_for 'ユーザーAが作成したタスクが表示される' do
#     it { expect(page).to have_content '最初のタスク' }
#   end
#
#   describe '一覧表示機能' do
#     context 'ユーザーAがログインしているとき' do
#       # ユーザーAでログインする
#       let(:login_user) { user_a }
#
#       it_behaves_like 'ユーザーAが作成したタスクが表示される'
#     end
#
#     context 'ユーザーBがログインしているとき' do
#       # ユーザーBでログインする
#       let(:login_user) { user_b }
#
#       it 'ユーザーAが作成したタスクが表示されない' do
#         # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
#         expect(page).to have_no_content '最初のタスク'
#       end
#     end
#   end
#
#   describe '詳細表示機能' do
#     context 'ユーザーAがログインしているとき' do
#       let(:login_user) { user_a}
#
#       before do
#         visit task_path(task_a)
#       end
#
#       it_behaves_like 'ユーザーAが作成したタスクが表示される'
#     end
#   end
# end
