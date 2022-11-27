# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Schedules', type: :system, js: true do
  describe 'システムスペック' do
    let(:user) { FactoryBot.create(:user) }
    let(:variety) { FactoryBot.create(:variety, id: 1) }
    before do
      @schedule = FactoryBot.create(:schedule, id: 1, user_id: user.id, variety_id: variety.id, prefecture_id:47)
      @task = FactoryBot.create(:task, schedule_id: @schedule.id, user_id: user.id, name: '酸性土壌を作れ')
    end

    context 'ゲストがアクセスする' do
      it 'スケジュール一覧が表示される' do
        visit schedules_path
        expect(page).to have_content 'みんなの栽培スケジュール'
        expect(page).to have_content 'とうだいのひまわり'
        expect(page).not_to have_content '酸性土壌を作れ'
      end
      it 'スケジュール詳細が表示される' do
        visit schedule_path(1)
        expect(page).to have_content 'とうだいのひまわり'
        expect(page).to have_content '酸性土壌を作れ'
      end
      it 'コピーリンクが表示されない' do
        visit schedule_path(1)
        expect(page).not_to have_content 'このスケジュールをコピー'
      end
      it '編集ボタンが表示されない' do
        get '/schedules/1'
        expect(response.body).not_to include '編集'
        visit schedule_path(1)
        expect(page).not_to have_content '編集'
      end
      it '削除ボタンが表示されない' do
        get '/schedules/1'
        expect(response.body).not_to include '削除'
        visit schedule_path(1)
        expect(page).not_to have_content '削除'
      end
      it 'スケジュール作成画面が表示されない' do
        get '/schedules/new'
        expect(response).to redirect_to('/users/sign_in')
      end
      it 'スケジュール編集画面が表示されない' do
        get '/schedules/1/edit'
        expect(response).to redirect_to('/')
      end
    end

    context 'ユーザーがアクセスする' do
      it 'スケジュール一覧が表示される' do
        sign_in user
        visit schedules_path
        expect(page).to have_content 'とうだいのひまわり'
        expect(page).not_to have_content '酸性土壌を作れ'
      end
      it 'スケジュール詳細が表示される' do
        sign_in user
        visit schedule_path(1)
        expect(page).to have_content 'とうだいのひまわり'
        expect(page).to have_content '酸性土壌を作れ'
      end
      it 'コピーリンクが表示される' do
        sign_in user
        visit schedule_path(1)
        expect(page).to have_content 'このスケジュールをコピー'
      end
      it '編集ボタンが表示される' do
        sign_in user
        visit schedule_path(1)
        expect(page).to have_content '編集'
      end
      it 'スケジュール作成画面が表示される' do
        sign_in user
        visit new_schedule_path
        expect(page).to have_content 'スケジュール作成'
      end
      it 'スケジュール編集画面が表示される' do
        sign_in user
        visit edit_schedule_path(1)
        expect(page).to have_content 'スケジュール編集'
      end
    end

    context 'スケジュール一覧の表示' do
      it '品種指定で絞り込みができる' do
        FactoryBot.create(:variety, id: 2, name: 'さくらんぼ')
        FactoryBot.create(:schedule, id: 2, variety_id: 2, prefecture_id:7)
        FactoryBot.create(:variety, id: 3, name: 'マリーゴールド')
        FactoryBot.create(:schedule, id: 3, variety_id: 3, prefecture_id:13)
        FactoryBot.create(:variety, id: 4, name: 'ハナミズキ')
        FactoryBot.create(:schedule, id: 4, variety_id: 4, prefecture_id:31)

        visit schedules_path
        expect(page).to have_css('.schedule-card', count: 4)

        select('さくらんぼ', from: 'variety_select')
        uri = URI.parse(current_url)
        expect("#{uri.path}?#{uri.query}").to eq('/schedules?variety_id=2&prefecture_id=')
        visit schedules_path(variety_id: 2, prefecture_id: '')
        expect(page).to have_css('.schedule-card', count: 1)
      end
      it '都道府県指定で絞り込みができる' do
        FactoryBot.create(:variety, id: 2, name: 'さくらんぼ')
        FactoryBot.create(:schedule, id: 2, variety_id: 2, prefecture_id:7)
        FactoryBot.create(:variety, id: 3, name: 'マリーゴールド')
        FactoryBot.create(:schedule, id: 3, variety_id: 3, prefecture_id:13)
        FactoryBot.create(:variety, id: 4, name: 'ハナミズキ')
        FactoryBot.create(:schedule, id: 4, variety_id: 4, prefecture_id:31)

        visit schedules_path
        expect(page).to have_css('.schedule-card', count: 4)

        select('東京都', from: 'prefecture_select')
        uri = URI.parse(current_url)
        expect("#{uri.path}?#{uri.query}").to eq('/schedules?variety_id=&prefecture_id=13')
        visit schedules_path(variety_id: '', prefecture_id: 13)
        expect(page).to have_css('.schedule-card', count: 1)
      end
      it '自分のスケジュールのみ絞り込みができる' do
        FactoryBot.create(:schedule, id: 2, user_id: user.id, variety_id: 1)
        FactoryBot.create(:schedule, id: 3, user_id: user.id, variety_id: 1)
        @user2 = FactoryBot.create(:user, id: 2)
        FactoryBot.create(:schedule, id: 4, user_id: @user2.id, variety_id: 1)

        sign_in @user2
        visit schedules_path
        expect(page).to have_css('.schedule-card', count: 4)

        check('only_mine')
        uri = URI.parse(current_url)
        expect("#{uri.path}?#{uri.query}").to eq('/schedules?variety_id=&prefecture_id=&only_mine=true')
        visit schedules_path(variety_id: '', prefecture_id: '', only_mine: true)
        expect(page).to have_css('.schedule-card', count: 1)
      end
    end

    context 'ユーザーによるスケジュールの作成変更削除' do
      it 'スケジュールを作成できる' do
        FactoryBot.create(:variety, id: 2, name: 'さくらんぼ')
        sign_in user
        visit root_path
        expect(page).to have_content '今後の予定作業'
        expect(page).to have_content '作成'
        click_link('作成')

        expect(page).to have_content 'スケジュール作成'
        fill_in('schedule[name]', with: 'テストの畑')
        select('和歌山県', from: 'schedule[prefecture_id]')
        select('さくらんぼ', from: 'schedule[variety_id]')
        click_on('登録する')

        expect(page).to have_content 'スケジュールを登録しました。'
        expect(page).to have_content 'さくらんぼ(テストの畑)@和歌山県'
      end

      it 'スケジュールの変更、タスクの追加ができる' do
        FactoryBot.create(:variety, id: 3, name: 'あっちの花')
        sign_in user
        visit edit_schedule_path(1)
        expect(page).to have_content 'スケジュール編集'
        expect(find('#schedule_name').value).to eq 'テストスケジュール01'

        fill_in('schedule[name]', with: 'テストスケジュール01改')
        fill_in('schedule[tasks_attributes][0][date]', with: '12-31-2025')
        select('元肥', from: 'schedule[tasks_attributes][0][name]')
        fill_in('schedule[tasks_attributes][0][plan_memo]', with: '重労働')
        click_on('更新する')
        expect(page).to have_content 'スケジュールを更新しました。'
        expect(page).to have_content '2025年12月31日(水) 元肥'
        expect(page).to have_content '作業メモ: 重労働'
      end

      it 'スケジュールを削除できる' do
        sign_in user
        visit schedules_path
        expect(page).to have_content 'みんなの栽培スケジュール'
        expect(page).to have_content 'とうだいのひまわり@沖縄県'
        click_link('とうだいのひまわり@沖縄県')
        click_link('削除')
        expect {
          page.accept_confirm "本当に削除しますか?"
          expect(page).to have_content "スケジュールを削除しました。"
        }.to change { Schedule.count }.by(-1)
        expect(page).not_to have_content 'あっちの花(試験中の畑)@三重県'
      end
    end
  end
end
