window.addEventListener('load', function(){
  
  const likeCreateBtn = document.getElementById("like-createBtn")
  const likeDeleteBtn = document.getElementById("like-deleteBtn")

  likeCreateBtn.addEventListener('click', function() {
      this.removeId( 'like-createBtn' );
      this.addId( 'like-deleteBtn' );
  })

  likeDeleteBtn.addEventListener('click', function() {
    this.removeId( 'like-deleteBtn' );
    this.addId( 'like-createBtn' );
})
})