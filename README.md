# Freedom　Style

## サイト概要
### サイトテーマ
自分のコーディネートを投稿したり、他の人のコーディネートを見て参考にできるサイトです。同じような服の趣味の人と繋がれるコミュニティサイトでもあります。

### テーマを選んだ理由
多様性が謳われる時代、洋服の種類やコーディネートの種類も増えましたが、その分自分が何を着るべきかわからない人もいると思います。
そこで体型やTPOなどによって、他の人の投稿を見てどんな服を着ているのかわかれば、自分の服選びもしやすくなります。
また、コーディネートで自分を表現したい人が表現する場にもなり、交流ができたら面白いと考えました。
自分に合ったコーディネートを効果的に探すことが検索エンジンとしての役割と、
個性を重視した文化を持つSNSとしての両面を備えたサイトとして機能することを想定しています。

### ターゲットユーザ
- 洋服選びに迷う人全般
- 自分のコーディネートを披露したい人
- コーディネートを通して人と交流したい人

### 主な利用シーン
- 洋服選びに迷った際の参考、自分のコーディネートを見てほしいとき
- 自分のコーディネートに意見がほしいとき
- 同じ趣向の人と交流したいとき

## アプリケーション機能

### ユーザー側
- ユーザー認証機能
- ゲストログイン機能
- コーディネート投稿機能
- アイテム保存機能
- コーディネート・アイテム紐付け機能
- マイページ機能(おすすめ投稿表示機能)
- タイムライン機能
- 検索機能(キーワード、各種条件設定可能)
- タグ検索機能
- いいね(ブックマーク)機能
- コメント機能
- フォロー機能
- 通知機能(いいね、コメント、フォロー)
- コメント通報機能

### 管理者側
- 管理者認証機能
- 投稿管理機能
- ユーザー管理機能
- アイテム管理機能
- コメント管理機能
- コメント通報確認機能

### その他
- レスポンシブ対応
- RSpec(投稿機能部分)

### 管理者用ログインアカウント
- メールアドレス: admin@test.com
- パスワード: aaaaaa

## 設計書
- ER図：https://app.diagrams.net/#G1dQLHJ1HT5Pm8M7VMjwfHJsUfp28D2hba
- テーブル定義書：https://docs.google.com/spreadsheets/d/1f4V1EAoIEo7YeRqLUvAKpUpWw7EOupQUU1ppW8BmrCI/edit#gid=931002870
- 詳細設計：https://docs.google.com/spreadsheets/d/1j1W-7xHJVkawBFEYuGp_ATOPFgLmSrZuvVbkXv38vyk/edit#gid=2133469642
- AWS構成図：https://app.diagrams.net/?src=about#G1acSO8gfYb32rDIWllK8GM-tsw39uLxHx
- インフラ設計書:https://docs.google.com/spreadsheets/d/1bZZlzKfkcDIiOxHgeN0H2YEdnXHkgrAyAhc6Ms_mZ7k/edit#gid=0

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 取り入れた技術
- ユーザー認証(devise)
- いいね機能の非同期通信(Ajax)
- フォロー機能の非同期通信(Ajax)
- コメント機能の非同期通信(Ajax)
- コメント通報ステータスの非同期通信(Ajax)
- 検索機能の非同期通信(Ajax)
- 画像アップロード・レビュー機能(ActiveStorage,jQuery)
- ヘッダーの自動隠し・一番上に戻る機能(jQuery)
- 天気検索機能(Ajax,外部API(OpenWeatherMap))
- GitHub Actions(CI/CDツール）による自動デプロイ
- SSL(https)認証

## 使用素材
- 画像フリー素材(photoAC：https://www.photo-ac.com/）