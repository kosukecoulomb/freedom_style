# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト', type: :system do
    let!(:coordinate) { create(:coordinate) }
    let!(:user) { create(:user) }

  describe "投稿画面(new_coordinate_path)のテスト" do
    before do
      sign_in user
      visit new_coordinate_path
    end
    context '表示の確認' do
      it 'new_coordinate_pathが"/coordinates/new"であるか' do
        expect(current_path).to eq('/coordinates/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'coordinate[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'coordinate[body]', with: Faker::Lorem.characters(number:20)
        select "カジュアル", from: "coordinate_dress_code"
        select "春", from: "coordinate_season"
        select "10度以下(寒い)", from: "coordinate_temperature"

        attach_file("coordinate_coordinate_image", "app/assets/images/non-item.jpg")
        click_button '投稿'
        expect(page).to have_current_path coordinate_path(Coordinate.last)
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      visit coordinates_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content coordinate.title
        expect(page).to have_link coordinate.title
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit coordinate_path(coordinate)
    end
    context '表示の確認' do
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集する'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/coordinates/' + coordinate.id.to_s + '/edit')
      end
    end
    context 'coordinate削除のテスト' do
      it 'coordinateの削除' do
        expect{ coordinate.destroy }.to change{ Coordinate.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_coordinate_path(coordinate)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'coordinate[title]', with: coordinate.title
        expect(page).to have_field 'coordinate[body]', with: coordinate.body
        expect(page).to have_filed 'coordinate[dress_code]', with: coordinate.dress_code
        expect(page).to have_filed 'coordinate[season]', with: coordinate.season
        expect(page).to have_filed 'coordinate[temperature]', with: coordinate.temperature
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '編集を保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'coordinate[title]', with: Faker::Lorem.characters(number:5)
        fill_in 'coordinate[body]', with: Faker::Lorem.characters(number:20)
        select "カジュアル", from: "coordinate_dress_code"
        select "春", from: "coordinate_season"
        select "10度以下(寒い)", from: "coordinate_temperature"
        
        attach_file("coordinate_coordinate_image", "app/assets/images/non-item.jpg")
        click_button '保存'
        expect(page).to have_current_path coordinate_path(coordinate)
      end
    end
  end
end