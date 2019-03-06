# Nasa-Pictures

No aplicativo Nasa Pictures, você pode ver as últimas fotos tiradas pelas três sondas da Nasa, Curiosity, Opportunity e Spirit.
![img](https://user-images.githubusercontent.com/6620203/53886656-48acb800-3fff-11e9-9823-5a43bb8ce568.png)

Clicando na foto, voce vai ver o detalhe da foto escolhida
![img](https://user-images.githubusercontent.com/6620203/53887184-7f370280-4000-11e9-81b3-658449f7e99a.png)

Implementação
O aplicativo contém duas ViewControllers, HomeViewController e PictureDetailViewController, na HomeViewController é feito requisições 
sempre para pegar as fotos das sondas, quando não é retornado nada na requisição, é feito uma requisição para o dia anterior, e assim continua até
encontrar ao menos uma foto da sonda, quando voce clica em uma foto voce pode ver os detalhes dela carregados na PictureDetailViewController.

Compilação

Somente baixe o projeto pelo git ou baixe o zip e rode, a chave da api da Nasa que está sendo usada foi uma que criei, caso queira utilizar outra chave, acesse https://api.nasa.gov e crie uma nova chave, após isso vá ao projeto e na função getData, que fica na classe Client, altere a url  da requisição a partir de api_key=SUANOVACHAVE

Requisitos
* Xcode 10
* Swift 4.2
