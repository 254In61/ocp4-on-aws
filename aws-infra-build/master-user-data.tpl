{
  "ignition": {
    "config": {
      "merge": [
        {
          "source": "${SOURCE}"
        }
      ]
    },
    "security": {
      "tls": {
        "certificateAuthorities": [
          {
            "source": "${CA_BUNDLE}"
          }
        ]
      }
    },
    "version": "3.1.0"
  }
}