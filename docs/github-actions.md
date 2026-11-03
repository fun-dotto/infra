# GitHub Actions の Environment・Variable・Secret

各リポジトリの Environment・Variable・Secret は `terraform/github/fun-dotto/repository-<リポジトリ名>.tf`（`terraform/modules/github-repository` を利用）で管理する。

- Variable: 値を各リポジトリの `repository-*.tf` に直接書く。値が `null` のものは Terraform 管理外（未作成・既存値を維持）
- Secret: 名前を `secrets` に列挙すると、Secret Manager のシークレット `github_actions_<リポジトリ名>_<Secret 名の小文字>` が作成され、その値が GitHub に登録される
  - 値（バージョン）は Terraform 管理外のため手動で登録する
  - 値は tfstate にも保存される

## Secret を追加する

1. `secrets` に名前を追加して apply する（シークレットの作成後、値が未登録のため Secret の登録で失敗する）
2. 値を登録して、再度 apply する

```bash
gcloud secrets versions add github_actions_app_match_password --project=swift2023groupc --data-file=-
```
