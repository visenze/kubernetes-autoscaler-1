module k8s.io/autoscaler/cluster-autoscaler

require (
	cloud.google.com/go v0.0.0-20160913182117-3b1ae45394a2
	github.com/Azure/go-ansiterm v0.0.0-20170629204627-19f72df4d05d
	github.com/Azure/go-autorest v9.9.0+incompatible
	github.com/JeffAshton/win_pdh v0.0.0-20161109143554-76bb4ee9f0ab
	github.com/MakeNowJust/heredoc v0.0.0-20170808103936-bb23615498cd
	github.com/Microsoft/go-winio v0.4.5
	github.com/Microsoft/hcsshim v0.6.3
	github.com/NYTimes/gziphandler v0.0.0-20170623195520-56545f4a5d46
	github.com/Nvveen/Gotty v0.0.0-20120604004816-cd527374f1e5
	github.com/PuerkitoBio/purell v1.0.0
	github.com/PuerkitoBio/urlesc v0.0.0-20160726150825-5bd2802263f2
	github.com/abbot/go-http-auth v0.0.0-20140618235127-c0ef4539dfab
	github.com/armon/circbuf v0.0.0-20150827004946-bbbad097214e
	github.com/beorn7/perks v0.0.0-20160229213445-3ac7bf7a47d1
	github.com/blang/semver v3.5.0+incompatible
	github.com/clusterhq/flocker-go v0.0.0-20160920122132-2b8b7259d313
	github.com/codedellemc/goscaleio v0.0.0-20170830184815-20e2ce2cf885
	github.com/container-storage-interface/spec v0.2.0
	github.com/containerd/console v0.0.0-20170925154832-84eeaae905fa
	github.com/coreos/go-semver v0.0.0-20150304020126-568e959cd898
	github.com/coreos/go-systemd v0.0.0-20161114122254-48702e0da86b
	github.com/coreos/pkg v0.0.0-20160620232715-fa29b1d70f0b
	github.com/d2g/dhcp4 v0.0.0-20170904100407-a1d1b6c41b1c
	github.com/d2g/dhcp4client v0.0.0-20170829104524-6e570ed0a266
	github.com/davecgh/go-spew v0.0.0-20170626231645-782f4967f2dc
	github.com/dchest/safefile v0.0.0-20151022103144-855e8d98f185
	github.com/dgrijalva/jwt-go v0.0.0-20160705203006-01aeca54ebda
	github.com/docker/go-connections v0.3.0
	github.com/docker/go-units v0.0.0-20170127094116-9e638d38cf69
	github.com/docker/libtrust v0.0.0-20150526203908-9cbd2a1374f4
	github.com/docker/spdystream v0.0.0-20160310174837-449fdfce4d96
	github.com/elazarl/go-bindata-assetfs v0.0.0-20150624150248-3dcc96556217
	github.com/emicklei/go-restful v0.0.0-20170410110728-ff4f55a20633
	github.com/emicklei/go-restful-swagger12 v0.0.0-20170208215640-dcef7f557305
	github.com/euank/go-kmsg-parser v2.0.0+incompatible
	github.com/evanphx/json-patch v0.0.0-20170719203123-944e07253867
	github.com/exponent-io/jsonpath v0.0.0-20151013193312-d6023ce2651d
	github.com/fatih/camelcase v0.0.0-20160318181535-f6a740d52f96
	github.com/fsnotify/fsnotify v0.0.0-20160816051541-f12c6236fe7b
	github.com/ghodss/yaml v0.0.0-20150909031657-73d445a93680
	github.com/go-ini/ini v1.25.4
	github.com/go-openapi/jsonpointer v0.0.0-20160704185906-46af16f9f7b1
	github.com/go-openapi/jsonreference v0.0.0-20160704190145-13c6e3589ad9
	github.com/go-openapi/spec v0.0.0-20180213232550-1de3e0542de6
	github.com/go-openapi/swag v0.0.0-20170606142751-f3f9494671f9
	github.com/godbus/dbus v0.0.0-20151105175453-c7fdd8b5cd55
	github.com/gogo/protobuf v0.0.0-20170330071051-c0656edd0d9e
	github.com/golang/glog v0.0.0-20141105023935-44145f04b68c
	github.com/golang/groupcache v0.0.0-20160516000752-02826c3e7903
	github.com/golang/mock v0.0.0-20160127222235-bd3c8e81be01
	github.com/golang/protobuf v0.0.0-20171021043952-1643683e1b54
	github.com/google/btree v0.0.0-20160524151835-7d79101e329e
	github.com/google/gofuzz v0.0.0-20161122191042-44d81051d367
	github.com/googleapis/gnostic v0.0.0-20170729233727-0c5108395e2d
	github.com/gophercloud/gophercloud v0.0.0-20180210024343-6da026c32e2d
	github.com/gorilla/websocket v0.0.0-20150714140627-6eb6ad425a89
	github.com/gregjones/httpcache v0.0.0-20170728041850-787624de3eb7
	github.com/hashicorp/golang-lru v0.0.0-20160207214719-a0d98a5f2880
	github.com/heketi/heketi v0.0.0-20170623005005-aaf40619d85f
	github.com/howeyc/gopass v0.0.0-20170109162249-bf9dde6d0d2c
	github.com/imdario/mergo v0.0.0-20141206190957-6633656539c1
	github.com/inconshreveable/mousetrap v1.0.0
	github.com/jmespath/go-jmespath v0.0.0-20160202185014-0b12d6b521d8
	github.com/json-iterator/go v0.0.0-20171212105241-13f86432b882
	github.com/kardianos/osext v0.0.0-20150410034420-8fef92e41e22
	github.com/kr/fs v0.0.0-20131111012553-2788f0dbd169
	github.com/kr/pty v0.0.0-20151007230424-f7ee69f31298
	github.com/lpabon/godbc v0.0.0-20140613165803-9577782540c1
	github.com/mailru/easyjson v0.0.0-20170624190925-2f5df55504eb
	github.com/marstr/guid v0.0.0-20170427235115-8bdf7d1a087c
	github.com/matttproud/golang_protobuf_extensions v0.0.0-20150406173934-fc2b8d3a73c4
	github.com/miekg/dns v0.0.0-20160614162101-5d001d020961
	github.com/mindprince/gonvml v0.0.0-20171110221305-fee913ce8fb2
	github.com/mistifyio/go-zfs v0.0.0-20151009155749-1b4ae6fb4e77
	github.com/mitchellh/go-wordwrap v0.0.0-20150314170334-ad45545899c7
	github.com/mitchellh/mapstructure v0.0.0-20170307201123-53818660ed49
	github.com/mohae/deepcopy v0.0.0-20170603005431-491d3605edfb
	github.com/mrunalp/fileutils v0.0.0-20160930181131-4ee1cc9a8058
	github.com/opencontainers/go-digest v0.0.0-20170106003457-a6d0ee40d420
	github.com/opencontainers/image-spec v0.0.0-20170604055404-372ad780f634
	github.com/opencontainers/runtime-spec v1.0.0
	github.com/opencontainers/selinux v0.0.0-20170621221121-4a2974bf1ee9
	github.com/pborman/uuid v0.0.0-20150603214016-ca53cad383ca
	github.com/peterbourgon/diskv v2.0.1+incompatible
	github.com/pkg/errors v0.8.0
	github.com/pkg/sftp v0.0.0-20160930220758-4d0e916071f6
	github.com/pmezard/go-difflib v0.0.0-20151028094244-d8ed2627bdf0
	github.com/prometheus/client_golang v0.0.0-20170531130054-e7e903064f5e
	github.com/prometheus/client_model v0.0.0-20150212101744-fa8ad6fec335
	github.com/prometheus/common v0.0.0-20170427095455-13ba4ddd0caa
	github.com/prometheus/procfs v0.0.0-20170519190837-65c1f6f8f0fc
	github.com/quobyte/api v0.0.0-20171020135407-f2b94aa4aa4f
	github.com/renstrom/dedent v0.0.0-20150819195903-020d11c3b9c0
	github.com/russross/blackfriday v0.0.0-20151117072312-300106c228d5
	github.com/satori/go.uuid v1.1.0
	github.com/seccomp/libseccomp-golang v0.0.0-20150813023252-1b506fc7c24e
	github.com/shurcooL/sanitized_anchor_name v0.0.0-20151028001915-10ef21a441db
	github.com/sirupsen/logrus v0.0.0-20170822132746-89742aefa4b2
	github.com/spf13/afero v0.0.0-20160816080757-b28a7effac97
	github.com/spf13/cobra v0.0.0-20180228053838-6644d46b81fa
	github.com/spf13/pflag v0.0.0-20171106142849-4c012f6dcd95
	github.com/storageos/go-api v0.0.0-20180126153955-3a4032328d99
	github.com/stretchr/objx v0.0.0-20150928122152-1a9d0bb9f541
	github.com/syndtr/gocapability v0.0.0-20160928074757-e7cb7fa329f4
	github.com/ugorji/go v0.0.0-20170107133203-ded73eae5db7
	github.com/vishvananda/netlink v0.0.0-20171128170821-f67b75edbf5e
	github.com/vishvananda/netns v0.0.0-20171111001504-be1fbeda1936
	github.com/vmware/photon-controller-go-sdk v0.0.0-20170310013346-4a435daef6cc
	github.com/xanzy/go-cloudstack v0.0.0-20160728180336-1e2cbf647e57
	go4.org v0.0.0-20160314031811-03efcb870d84
	golang.org/x/crypto v0.0.0-20170825220121-81e90905daef
	golang.org/x/net v0.0.0-20170809000501-1c05540f6879
	golang.org/x/oauth2 v0.0.0-20170412232759-a6bd8cefa181
	golang.org/x/sys v0.0.0-20171031081856-95c657629925
	golang.org/x/text v0.0.0-20170810154203-b19bf474d317
	golang.org/x/time v0.0.0-20161028155119-f51c12702a4d
	google.golang.org/genproto v0.0.0-20170731182057-09f6ed296fc6
	google.golang.org/grpc v1.7.5
	gopkg.in/gcfg.v1 v1.2.0
	gopkg.in/inf.v0 v0.9.0
	gopkg.in/square/go-jose.v2 v2.1.3
	gopkg.in/warnings.v0 v0.1.1
	gopkg.in/yaml.v2 v2.0.0-20170721113624-670d4cfef054
	k8s.io/kube-openapi v0.0.0-20180216212618-50ae88d24ede
	k8s.io/utils v0.0.0-20171122000934-aedf551cdb8b
	vbom.ml/util v0.0.0-20160121211510-db5cfe13f5cc
)
