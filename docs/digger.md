# Digger

このリポジトリでは Digger Community Edition の backendless mode を使い、
Google Cloud の Terraform を GitHub Actions から実行する。

## GitHub の設定

Repository settings の Actions > General > Workflow permissions で
`Read and write permissions` を選択する。ワークフローは Pull Request への
コメント、commit status、plan cache の更新に書き込み権限を使う。

Pull Request を作ると、変更に該当する `digger.yml` の project に対して plan が
実行される。必要に応じて Pull Request へ次のコメントを追加する。

- `digger plan`
- `digger apply`

## Google Cloud の設定

GitHub Actions はサービスアカウントキーを使わず、既存の Workload Identity
Provider と `terraform-ci` サービスアカウントを使う。

`terraform-ci` には、管理対象リソースに必要な最小権限に加えて、次の GCS
オブジェクト操作権限が必要になる。

- Terraform state の読み書き
- `swift2023groupc-tfstate` バケットに保存する Digger の PR lock の作成、参照、削除

権限は環境の運用方針に合わせて IAM で付与する。Pull Request から実行される
サービスアカウントに project-wide の `roles/owner` は付与しない。

## Project の追加

Terraform root（`backend.tf` を持つディレクトリ）を追加した場合は、同じ変更で
`digger.yml` に project を追加する。共有ファイルを symlink している project は、
対応する `_shared` ディレクトリを `include_patterns` に含める。
