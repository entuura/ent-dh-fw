#!/bin/sh
# Entuura Ventures Limited
# Steven Uggowitzer steven@entuura.org

#-----------------------------------------------------------------------------
# SSH Keys Setup
# CLEAN
SSH_KEY1='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDkKUiCprVH0eGdsRuelV9p35lnbDUdYjTtWld8Qr5tdwfWlsMFM83tiBiEFSKzJter4KckwplMKcPtRSEtPJ5+ssKxap1191pIT+4Ttyt89lqB2AnMcSpOafk8f4bPQmf5xeIR9nh7om6GcKS5XeZeNkJ7nD5TlKSm8ChHU95UZ3oUgEKt1i+6jBCsmHXeyLbqCnM0lWcOWqCkX1bUrNhpDuKCODids4xue+e+OYLRgb/KfhSZQP3aMuzwopMajIiLirQua7iApIv0Iwk6e2UmKtgfWVtHM3jiL+jy/Qede2faBXtb4ehMx7eaDCw2o2zCCs2jgvVl1uESJ75pFxNT stevie@razor'
SSH_KEY2='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDD+SbMia36AHCg5SlBFivVKVK6jF3GBaW7NxcYGmUNthQ5liVSFUsXv4/va2OGCPixff8Ak+CQLoDE2XYr7qUUanOMH0xEE71IP2wg+rWTvRxcaLK757nyf7tnyk5Rq+JGWrU+jX51Bc2N9QoLO9qabLgoDZdBMnp7TsQuGh2SRgKR6jZ3kAmeSXg7legwIVdL27e583UCBWwXKWa8Hlhf2c4pvMCYucQx6KAD+duGqEoXovsaEIWAFihI2b+oRLaZgiKrCZv95IgZqmopR3HAFTWD+47HZOJLe8rRc9OS3tuT71Y8Kzku1zKyzFV/iyjHsQZ56tlME4XEAV7blXFH stevie@stevens-mbp'
SSH_KEY3='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDAkF6oS5s7J/GEbxwodZ4fy2vjE8es8/gqKXKETi5Rli7jWEvtcJkmf8teoGehMnmBh6/7hY1XJ9ZJHXjTLWIPmFC5J4wqMImne4wNScGIW6D1ysA6kuJyMqSExz4lrjVTlSXD6K36rDhc7w/us4/UJYStvUJSuxMglQ2l9dPLsgK/dZl1nCP0d62ffrIqagnPCLn+Dem6ZuS7rHErgjyicDcHHX2qFEYLtu0vyl5aeOE05PDLPlBfIaBqTjM3w7B2F7BbPkAnNgLj10sI/a5tHlqF7ZY4CxjsYRoxIe9uECbpagcsxf8tueN2wrCT1I4BhAYvRmCGodCZqbs3n+OTl7uBaGO3hr63sPj/rS85yWB0cY4cewLTbM0TvJswEvA0gx20F1owLGhHwCJvO0St39juLHddwLUp+KhpNQAaKYoL6ww8J+IbmO+MXIMB9LisxHvOMAQ7jCELraGqQ43UVGvBIY2RvlhJTjS8Ydpqkqi5GGfR42RBH+2d1iURbFjJZh27XzrTFrVBTJB15ejYFTkd8UW+aeJUYUDJB55CXkjM6UaslTWC5x39MznJTS4e/BNAYE/thNl8RO16IUOD8DwuQHornfBbx+yasIXyZ0xAJg+HLONArUOhJgcTaZoVh7OUqhlqNjGwL/vKaIG29s+l3qw+RhUtYYes6kW0yQ== helpdesk@entuura.org'

SSHKEYFILE='/etc/dropbear/authorized_keys'
echo $SSH_KEY1 > $SSHKEYFILE
echo $SSH_KEY2 >> $SSHKEYFILE
echo $SSH_KEY3 >> $SSHKEYFILE
chmod 644 $SSHKEYFILE

#-----------------------------------------------------------------------------
