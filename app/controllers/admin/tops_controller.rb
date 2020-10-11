class Admin::TopsController < ApplicationController
before_action :authenticate_admin!
  def top

   @orders = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    #whereは与えられた条件にマッチするレコードを全て返す
    #今回は今日来た注文の日をマッチさせている
    #参考URLはこれhttps://easyramble.com/get-today-record-with-rails-activerecord.html
    #https://qastack.jp/programming/2919720/how-to-get-record-created-today-by-rails-activerecord
  end
end
#https://www.javadrive.jp/ruby/date_class/index4.html

#下記の記述は本日の注文ではなく、コントローラに記述した前後24時間のデータを取得している。

#@orders = Order.where("created_at" === Date.today)
#Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

