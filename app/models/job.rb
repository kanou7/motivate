class Job < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '学生' },
    { id: 3, name: '専業主婦' },
    { id: 4, name: '受験生' },
    { id: 5, name: '浪人生' },
    { id: 6, name: '離職者' },
    { id: 7, name: '定年後' },
    { id: 8, name: 'フリーター' },
    { id: 9, name: '医療関係' },
    { id: 10, name: '心理、福祉、リハビリ' },
    { id: 11, name: '美容、ファッション' },
    { id: 12, name: '旅行、ホテル' },
    { id: 13, name: '飲食' },
    { id: 14, name: '販売' },
    { id: 15, name: '教育、研究、保育' },
    { id: 16, name: '自然、動物' },
    { id: 17, name: '出版、報道' },
    { id: 18, name: 'テレビ、映画' },
    { id: 19, name: '音楽、ラジオ' },
    { id: 20, name: '芸能、ネット' },
    { id: 21, name: 'スポーツ' },
    { id: 22, name: '漫画、アニメ、ゲーム' },
    { id: 23, name: 'デザイン、広告、アート' },
    { id: 24, name: 'IT、Web' },
    { id: 25, name: '法律、士業、政治' },
    { id: 26, name: '公務員' },
    { id: 27, name: '金融、コンサル' },
    { id: 28, name: '国際' },
    { id: 29, name: '建築、インテリア、不動産' },
    { id: 30, name: '事務、秘書' },
    { id: 31, name: 'オフィス、職種' },
    { id: 32, name: '企業' },
    { id: 33, name: '運送、輸送' },
    { id: 34, name: '保安' },
    { id: 35, name: '葬祭、宗教' },
    { id: 36, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :users
end
