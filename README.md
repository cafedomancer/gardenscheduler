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
