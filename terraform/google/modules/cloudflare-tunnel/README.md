# Cloudflare Tunnel on Cloud Run Worker Pools

Cloud Run Worker Pool 上で `cloudflared` を常時実行し、Direct VPC egress と
Private Google Access を経由して内部公開の Cloud Run に接続する。

## 初回構築

Secret の値は Terraform state に残さない。最初に Secret とネットワークを作成する。

```console
terraform apply -target=google_secret_manager_secret.tunnel_token \
  -target=google_compute_subnetwork.cloudflared \
  -target=google_dns_record_set.run_app \
  -target=google_dns_record_set.run_app_wildcard
```

Cloudflare Zero Trust で remotely-managed Tunnel を作成し、表示されたトークンを
Secret Manager に登録する。

```console
printf '%s' "$CLOUDFLARE_TUNNEL_TOKEN" | \
  gcloud secrets versions add cloudflared-token --data-file=-
```

その後、通常どおり `terraform apply` して Worker Pool を作成する。

Cloudflare 側では Access Application と許可ポリシーを先に作り、その後 Published
application route を追加する。Origin service には対象 Cloud Run の `https://*.run.app`
URLを指定し、HTTP Host Header に同じ URL のホスト名を指定する。
