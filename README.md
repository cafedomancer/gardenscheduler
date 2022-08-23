# GardenScheduler

GardenSchedulerは、植物の栽培スケジュールを作成し、必要な時期になるとLINEで通知を受けることができる、栽培スケジュール管理サービスです。
自分で作成した栽培スケジュールを他の利用者と共有できる機能が特徴です。

# 起動方法

```
$ git clone git@github.com:NorifumiOgawa/gardenscheduler.git
$ cd gardenscheduler
$ docker-compose build --no-cache 
$ docker-compose up
$ docker-compose exec web rails db:create
```

```
docker-compose exec web rails webpacker:install
docker-compose exec web rails webpacker:compile
```


# .env

```
LINE_KEY='1657288949'
LINE_SECRET='4cdad65a0002d421614a745c22937b6d'
```

# Variety登録

```
Variety.create!(
  [
    {
      name: 'ハイビスカス',
      user_id: 1
    },
    {
      name: 'バナナ',
      user_id: 1
    },
    {
      name: 'コーヒー',
      user_id: 1
    },
    {
      name: 'マニラヤシ',
      user_id: 1
    },
    {
      name: 'パッションフルーツ',
      user_id: 1
    },
    {
      name: 'ゴーヤー',
      user_id: 1
    },
    {
      name: '姫高麗芝',
      user_id: 1
    }
  ]
)
```
