moovie {
    {
      /moovieP (popular)
      /moovieTR (top rated)
      /moovieU (upcoming)
      /moovieD (discover)
    }
    parametres optionel : page (int)
    faire un premiere appel sans parametres page pour obtenir la 1ere page, ainsi qu'un parametres "total_pages" qui permetra de faire appel au page suivante


    {
      /moovieL (latest)
    }
    pas de parametres


    {
      /moovieI (information)
      /moovieIm (images)
      /moovieV (vidéo)
      /moovieT (traduction)
    }
    parametres obligatoire : Id (int)
    passer en parametres l'id du film récuperer grace au call précédent


    {
      /moovieR (recomandation)
      /moovieS (similar)
    }
    parametres optionel : page (int)
    parametres obligatoire : Id (int)
    passer en parametres l'id du film récuperer grace au call précédent
    faire un premiere appel sans parametres page pour obtenir la 1ere page, ainsi qu'un parametres "total_pages" qui permetra de faire appel au page suivante
}


tv {
    {
      /tvP (popular)
      /tvTR (top rated)
      /tvD (discover)
    }
    parametres optionel : page (int)
    faire un premiere appel sans parametres page pour obtenir la 1ere page, ainsi qu'un parametres "total_pages" qui permetra de faire appel au page suivante


    {
      /tvL (latest)
    }
    pas de parametres


    {
      /tvI (information)
      /tvIm (images)
      /tvV (vidéo)
      /tvT (traduction)
    }
    parametres obligatoire : Id (int)
    passer en parametres l'id du film récuperer grace au call précédent


    {
      /tvR (recomandation)
      /tvS (similar)
    }
    parametres optionel : page (int)
    parametres obligatoire : Id (int)
    passer en parametres l'id du film récuperer grace au call précédent
    faire un premiere appel sans parametres page pour obtenir la 1ere page, ainsi qu'un parametres "total_pages" qui permetra de faire appel au page suivante
}
