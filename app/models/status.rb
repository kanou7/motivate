class Status < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '失業' },
    { id: 3, name: '中退' },
    { id: 4, name: '失恋' },
    { id: 5, name: '怪我、病気' },
    { id: 6, name: 'ハラスメント' },
    { id: 7, name: 'スランプ' },
    { id: 8, name: '貧乏' },
    { id: 9, name: 'いじめ' },
    { id: 10, name: '孤独' },
    { id: 11, name: '死別（ペット含む）' },
    { id: 12, name: '努力が実らない' },
    { id: 13, name: '鬱' },
    { id: 14, name: '就活難' },
    { id: 15, name: '不合格（不採用）' },
    { id: 16, name: '社会的被害' },
    { id: 17, name: '劣等感' },
    { id: 18, name: '金銭トラブル' },
    { id: 19, name: '裏切り' },
    { id: 20, name: '暴力' },
    { id: 21, name: '敗退（試合など）' },
    { id: 22, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :users
end
