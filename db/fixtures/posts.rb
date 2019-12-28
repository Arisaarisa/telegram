#Fakerの設定を日本語に設定
Faker::Config.locale = :ja

unless Rails.env.production?
  # 10件のでーたを用意する
  POST_MAX = 10
  
  #Proc.newでその後の配列をオブジェクトとしてpost_attrsに代入
  post_attrs = Proc.new do
    #Array.newでその後の内容を配列としてオブジェクト化する準備
    Array.new(POST_MAX) do |idx|
      { id: idx + 1,
      #FAkerを使って文言用意
        caption: Faker::Lorem.paragraph
    }
    end
  end

  #Proc.newでオブジェクト化したデータ(*post_attrs)を.callで呼び出して保存
  #seed_onceメソッドは上書きを行わない
  Post.seed_once(:id, *post_attrs.call)

  #追加したレコードに画像を追加
  Post.all.each do |p|
    #対応する画像があるか確認
    unless p.image.attached?
      #画像をattachメソッドで登録
      p.image.attach(io: File.open("db/fixtures/images/post/#{Random.rand(1..6)}.jpg"),filename: "#{Random.rand(1..6)}.jpg")
    end
  end

end