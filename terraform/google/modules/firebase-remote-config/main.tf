resource "google_firebase_remote_config_remote_config" "basic" {
  conditions {
    expression = "app.id == '1:107577467292:ios:f2e02b1b0cf3bdea06e859'"
    name       = "iOS"
    tag_color  = "DEEP_ORANGE"
  }
  conditions {
    expression = "app.id == '1:107577467292:android:bf5758604cdceb8506e859'"
    name       = "Android"
    tag_color  = "TEAL"
  }

  parameter_groups {
    description          = ""
    parameter_group_name = "Feature"

    parameters {
      description    = "Funch"
      parameter_name = "funch"
      value_type     = "BOOLEAN"

      default_value {
        use_in_app_default = false
        value              = "false"
      }
    }
    parameters {
      description    = "Web版"
      parameter_name = "web"
      value_type     = "BOOLEAN"

      default_value {
        use_in_app_default = false
        value              = "false"
      }
    }
    parameters {
      description    = "意見箱"
      parameter_name = "opinion_box"
      value_type     = "BOOLEAN"

      default_value {
        use_in_app_default = false
        value              = "false"
      }
    }
  }
  parameter_groups {
    description          = ""
    parameter_group_name = "Resource"

    parameters {
      description    = ""
      parameter_name = "app_store_page_url"
      value_type     = "STRING"

      conditional_values {
        condition_name     = "Android"
        use_in_app_default = false
        value              = "https://play.google.com/store/apps/details?id=jp.ac.fun.dotto"
      }
      conditional_values {
        condition_name     = "iOS"
        use_in_app_default = false
        value              = "https://apps.apple.com/jp/app/id6471561803"
      }

      default_value {
        use_in_app_default = false
        value              = ""
      }
    }
    parameters {
      description    = "Web版URL"
      parameter_name = "dotto_web_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://dotto.furari.co"
      }
    }
    parameters {
      description    = "MacサポートURL"
      parameter_name = "mac_support_desk_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://dotto.furari.co/mac"
      }
    }
    parameters {
      description    = "意見箱URL"
      parameter_name = "opinion_box_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://forms.gle/Y5xh3mNH1YptocSu7"
      }
    }
    parameters {
      description    = ""
      parameter_name = "feedback_form_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://forms.gle/SNsi7xd9hH9Zd1xw9"
      }
    }
    parameters {
      description    = ""
      parameter_name = "official_calendar_pdf_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://fun-dotto.github.io/files/official_calendar_2026.pdf"
      }
    }
    parameters {
      description    = ""
      parameter_name = "timetable_1_pdf_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://fun-dotto.github.io/files/timetable_2026_1.pdf"
      }
    }
    parameters {
      description    = ""
      parameter_name = "timetable_2_pdf_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://fun-dotto.github.io/files/timetable_2026_2.pdf"
      }
    }
    parameters {
      description    = ""
      parameter_name = "privacy_policy_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://fun-dotto.github.io/privacy-policy"
      }
    }
    parameters {
      description    = ""
      parameter_name = "terms_of_service_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://fun-dotto.github.io/terms-of-service"
      }
    }
    parameters {
      description    = ""
      parameter_name = "firebase_realtime_database_url"
      value_type     = "STRING"

      default_value {
        use_in_app_default = false
        value              = "https://swift2023groupc-default-rtdb.asia-southeast1.firebasedatabase.app"
      }
    }
  }

  parameters {
    description    = ""
    parameter_name = "valid_app_version"
    value_type     = "STRING"

    default_value {
      use_in_app_default = false
      value              = "2.0.2"
    }
  }
  parameters {
    description    = ""
    parameter_name = "latest_app_version"
    value_type     = "STRING"

    default_value {
      use_in_app_default = false
      value              = "2.0.3"
    }
  }
  parameters {
    description    = ""
    parameter_name = "privacy_policy_updated_at"
    value_type     = "STRING"

    default_value {
      use_in_app_default = false
      value              = "2025-07-08T00:00:00+09:00"
    }
  }
  parameters {
    description    = ""
    parameter_name = "terms_of_service_updated_at"
    value_type     = "STRING"

    default_value {
      use_in_app_default = false
      value              = "2025-07-08T00:00:00+09:00"
    }
  }
  parameters {
    description    = ""
    parameter_name = "is_under_maintenance"
    value_type     = "BOOLEAN"

    default_value {
      use_in_app_default = false
      value              = "false"
    }
  }
  parameters {
    description    = ""
    parameter_name = "breaking_announcement"
    value_type     = "JSON"

    default_value {
      use_in_app_default = false
      value              = "{\"title\":null,\"url\":null,\"is_external\":null}"
    }
  }
}
