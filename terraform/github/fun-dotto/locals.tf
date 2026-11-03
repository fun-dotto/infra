locals {
  repositories = {
    app = {
      description        = "公立はこだて未来大学ポータルアプリ Dotto モバイルアプリ"
      homepage_url       = "https://fun-dotto.github.io"
      topics             = ["app"]
      has_wiki           = false
      allow_merge_commit = true
      allow_auto_merge   = true
    }
    web = {
      description        = "公立はこだて未来大学ポータルアプリ Dotto Webアプリ"
      homepage_url       = ""
      topics             = []
      has_wiki           = false
      allow_merge_commit = true
      allow_auto_merge   = true
    }
    admin-web = {
      description        = "Dotto Admin"
      homepage_url       = "https://admin.dotto.furari.co"
      topics             = []
      has_wiki           = false
      allow_merge_commit = true
      allow_auto_merge   = true
    }
    client = {
      description        = "公立はこだて未来大学ポータルアプリ Dotto クライアント"
      homepage_url       = ""
      topics             = []
      has_wiki           = true
      allow_merge_commit = true
      allow_auto_merge   = true
    }
    server = {
      description        = "Dotto サーバー"
      homepage_url       = ""
      topics             = []
      has_wiki           = false
      allow_merge_commit = true
      allow_auto_merge   = true
    }
    infra = {
      description        = "Dotto インフラ"
      homepage_url       = ""
      topics             = []
      has_wiki           = false
      allow_merge_commit = false
      allow_auto_merge   = false
    }
  }
}
