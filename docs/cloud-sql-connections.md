# Cloud SQL の接続数の配分

Cloud SQL インスタンス `dotto` は全環境で共有し、`max_connections` の 100 も共用する。
各サービスの最大接続数は `max_instance_count × db_max_open_conns` で決まる。

| 環境 | サービス | `max_instance_count` | `db_max_open_conns` | 最大接続数 |
| --- | --- | --- | --- | --- |
| prd | academic-service | 3 | 4 | 12 |
| prd | user-service | 3 | 4 | 12 |
| prd | app-api | 3 | 4 | 12 |
| prd | announcement-service | 2 | 4 | 8 |
| prd | admin-api | 2 | 4 | 8 |
| prd | ジョブ 3 種 | 1 | 2 | 6 |
| stg | サービス 5 種 | 1 | 2 | 10 |
| stg | ジョブ 3 種 | 1 | 2 | 6 |
| dev | サービス 5 種 | 1 | 2 | 10 |
| dev | ジョブ 3 種 | 1 | 2 | 6 |

合計は 90 で、prd が 58、stg と dev が 16 ずつ。残りの 10 は Cloud SQL の予約接続、マイグレーション、手動接続に充てる。

`db_max_open_conns` は環境変数 `DB_MAX_OPEN_CONNS` としてコンテナに渡し、`server` リポジトリの接続プールが読み取る。

サービスやジョブを追加、変更するときは、この表の合計が 100 を超えないように更新する。

## 注意点

- デプロイ中は新旧のリビジョンが一時的に共存するため、接続数が表の値を超えることがある。残りの 10 を超える場合は順次デプロイする。
- `app-api` と `admin-api` は現在 BFF のバイナリを動かしており DB に接続しないが、統合後に備えて配分している。

## アラート

`terraform/google/modules/monitoring/alert-policies.tf` で定義している。

- インスタンス全体の接続数が 80 を 5 分間超えると CRITICAL
- `dotto_dev` または `dotto_stg` の接続数が配分の 16 を 5 分間超えると WARNING
