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

`digger plan` は Pull Request の状態にかかわらず実行できる。`digger apply` は、
required status checks、必須レビューなど、対象ブランチのルールを Pull Request が
すべて満たしている場合にのみ実行される。

## Google Cloud の設定

GitHub Actions はサービスアカウントキーもサービスアカウントの借用も使わず、
Direct Workload Identity Federation で認証する。IAM ロールは
`principal://iam.googleapis.com/.../subject/fun-dotto/infra` に直接付与する。

ロールは `terraform/google/modules/iam-workload-identity/principal_infra.tf` で
管理する。新しい種類のリソースを Terraform で管理する場合は、必要なロールを先に
追加する。Federated Identity には `roles/owner` を付与できない。

GCS については次の操作権限が必要になる。

- Terraform state の読み書き
- `swift2023groupc-tfstate` バケットに保存する Digger の PR lock の作成、参照、削除

Digger Action の認証は Service Account を必須とするため、`setup-google-cloud` は
`false` にして、Digger の前に `google-github-actions/auth` と `setup-gcloud` を
実行する。認証情報ファイルを残すため `configure-checkout` も `false` にし、
checkout はワークフロー側で行う。

`issue_comment` は常に `main` のワークフローで実行される。そのため、ワークフローの
変更は、マージするまで `digger plan` / `digger apply` のコメントには反映されない。

## Cloudflare の設定

`terraform/cloudflare/` の project は Cloudflare API Token を使う。Repository
secrets に `CLOUDFLARE_API_TOKEN` を登録する。Token には対象アカウントの
Cloudflare Tunnel・Access（アプリケーション・ポリシー）・Zero Trust の読み取りと、
`fun-dotto.com` ゾーンの DNS の編集権限を付与する。

Cloudflare Access の GitHub ログインに使う GitHub OAuth App の client secret を
`CLOUDFLARE_GITHUB_IDP_CLIENT_SECRET` として Repository secrets に登録する。

## Project の追加

Terraform root（`backend.tf` を持つディレクトリ）を追加した場合は、同じ変更で
`digger.yml` に project を追加する。共有ファイルを symlink している project は、
対応する `_shared` ディレクトリを `include_patterns` に含める。
