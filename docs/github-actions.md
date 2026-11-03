# GitHub Actions の Environment・Variable・Secret

各リポジトリの Environment・Variable・Secret は `terraform/github/fun-dotto/actions.tf` で管理する。

- Variable: 値を `actions.tf` に直接書く。値が `null` のものは Terraform 管理外（未作成・既存値を維持）
- Secret: 値は Secret Manager に保存し、Terraform が読み取って GitHub に登録する
  - シークレットは `terraform/google/foundation/secret-manager/github-actions.tf` で作成する
  - 値（バージョン）は Terraform 管理外のため手動で登録する
  - 値は tfstate にも保存される

## Secret の値を登録・更新する

```bash
gcloud secrets versions add github_actions_match_password --project=swift2023groupc --data-file=-
```

登録後、`terraform/github/fun-dotto` を plan / apply すると GitHub に反映される。
