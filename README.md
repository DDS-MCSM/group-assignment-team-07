# Group Assignment - Data Driven Security

Group Assignment base repository for the Data Driven Security subject of the [CyberSecurity Management Msc](https://www.talent.upc.edu/ing/professionals/presentacio/codi/221101/cybersecurity-management/).

## Proyecto ANTI-TYPOSQUATTING

El Phishing hoy en día, es uno de los principales riesgos a los que están expuestos los usuarios incautos. Consideremos las altas probabilidades de caer en este tipo de ataques. El Phishing o suplantación de identidad es un método utilizado por los Ciberdelincuentes para engañar a los usuarios y robar información, como por ejemplo números de tarjetas de crédito, contraseñas, cuentas bancarias, en resumen, cualquier información personal o corporativa que pueda ser sensible para cualquier individuo o compañía y cuyo su uso indebido representaría perjuicios económicos o personales serios.

Como bien mencionamos el método Phishing, es un problema grave para los propietarios de dominios, lo que representa un riesgo crítico, para la seguridad de cualquier sitio web y las empresas a menudo pasan por alto el “Phishing” cuando se desarrollan las políticas de seguridad. A pesar de todos estos riesgos muchos propietarios y compañías de dominios no aplican precauciones básicas que puedan proteger su dominio. Por ejemplo, ¿Una empresa que cuenta con un sitio web grande y que genere una alta rentabilidad, que impacto representaría designar un mínimo porcentaje de presupuesto en el Road Map de Seguridad para adquirir los nombres de dominio que tengan una semejanza al dominio principal y que puedan eventualmente ser usados para un ataque de Phishing? En la realidad muchas veces no es así, la gente compra un dominio rechazando las protecciones que pueden evitarles dolores de cabeza. 

De esta problemática nace la presente iniciativa llamada Proyecto ANTI-TYPOSQUATTING.


### Requerimientos

Los requerimientos clave para ejecución del presente proyecto son:
1.	Equipo de trabajo: Ingeniero desarrollador con habilidades en Hacking e Ingeniero Especialista en Análisis y estrategia de Cybersecurity.
2.	Herramientas técnicas: 
-	Integrated Development Environment (IDE) para el desarrollo del proyecto
-	Software de control de versiones
-	Soluciones o herramientas para validación de nombres de Dominio.

  
  
### Descripción del proyecto

El proyecto ANTI-TYPOSQUATTING, es la implementación de un control básico para la prevención del método de ataque cibernético Phishing, pero con un ingrediente importante que es el análisis avanzado de la información de sitios de dominio que aportaran utilidad a las estrategias de Ciberseguridad de las empresas.

Para el desarrollo del presente proyecto es importante profundizar y comprender algunos elementos en el contexto de ciberseguridad que serán de gran utilidad para el análisis y aplicación del Proyecto ANTI-TYPOSQUATTING. 
Primero vamos a conocer un poco sobre la naturaleza del nombre del nombre del proyecto:

Typosquatting, también conocido como URL hijacking, sting site, o fake URL. Es una forma de cybersquatting y/o de brandjacking, que se basa en los errores tipográficos cometidos por usuarios de internet cuando introducen la dirección de un sitio web en un navegador. Cuando esto sucede la dirección puede llevarlos a un sitio alternativo propiedad de un cybersquatter.

La URL de los sitios web de cybersquatters usualmente sigue una de estas cinco variaciones:

- Un error ortográfico o una pronunciación extranjera de la URL. Ejemplo: ejemple.com
- Un error tipográfico. ejemlop.com
- Una URL expresada diferente. ejemplos.com
- Un TLD diferente. ejemplo.org
- Un ccTLD diferente. ejemplo.co

Una vez en el sitio web del typosquatter, el usuario puede ser engañado para que piense que están en el sitio web correcto a través del uso de logos similares o copiados, una interfaz de usuario o contenido similar, el fin de ello es el robo de información personal tal como contraseñas, tarjetas de crédito o la venta de productos y servicios1. En algunos casos pueden utilizar el phishing.

Hay muchas diferentes razones por las que un typosquatter pueda llegar a utilizar esta clase de engaño:

- Para vender el dominio con el error ortográfico al dueño del sitio web que imita.
- Para monetizar el dominio a través de publicidad.
- Para redirigir el sitio web con el error tipográfico a un competidor.
- Como un esquema de phishing con el fin de robar contraseñas, correos electrónicos, tarjetas de crédito o información personal.
- Para instalar malware o generadores de ganancia adware en los dispositivos de los visitantes.
- Para expresar una opinión diferente de la que el sitio web verdadero pretende.

Ejemplos

Desde 2006 existe una variante considerada como phishing/fraude de Google llamada "Goggle.com", entre 2011 y 2012 la URL redirigía al sitio web de Google.2 Mientras que un chequeo en 2019 revelo que el sitio web solo muestra las palabras "Goggle.com Inc.". Otro ejemplo del typosquatting es yuube.com tarjeteando a usuarios de YouTube, esta página redirigía a los usuarios a un sitio web malicioso que pedía a los usuarios que instalaran una extensión de seguridad a su navegador que era en realidad malware.3
Usuarios intentando visitar el sitio web del famoso juego de navegador Agar.io pueden haber cometido un error tipográfico en la URL llevándolos a agor.io. Visitar el sitio producía un jumpscare del famoso creepypasta Jeff the Killer. El sitio fue derribado en 2017.

Teniendo en cuenta esto una de las formas o la forma más efectiva de proteger los dominios de errores de escritura, es registrar los posibles nombres con faltas de ortografía o con variaciones antes que los ciberdelincuentes tengan la oportunidad de hacerlo.

Para complementar vamos a conocer información relevante que puede someterse a juicio y análisis para el desarrollo de los objetivos del presente proyecto:

¿Qué es SSL? SSL significa Secure Sockets Layer, una tecnología de cifrado creada originalmente por Netscape en la década de 1990. SSL crea una conexión cifrada entre su servidor web y el navegador web de sus visitantes, lo que permite que la información privada se transmita sin los problemas de escuchas, manipulación de datos y falsificación de mensajes.

Para habilitar SSL en un sitio web, deberá obtener un certificado SSL que lo identifique e instalarlo en su servidor web. Cuando un navegador web utiliza un certificado SSL, generalmente muestra un icono de candado, pero también puede mostrar una barra de direcciones verde. Una vez que haya instalado un certificado SSL, puede acceder a un sitio de forma segura cambiando la URL de http: // a https: //. Si SSL se implementa correctamente, la información transmitida entre el navegador web y el servidor web (ya sea información de contacto o de tarjeta de crédito) se cifra y solo la ve la organización propietaria del sitio web.

Millones de negocios en línea utilizan certificados SSL para proteger sus sitios web y permiten que sus clientes confíen en ellos. Para utilizar el protocolo SSL, un servidor web requiere el uso de un certificado SSL. Los certificados SSL son proporcionados por las Autoridades de Certificación (CA).

SSL vs. TLS

SSL y TLS generalmente significan lo mismo. TLS 1.0 fue creado por RFC 2246 en enero de 1999 como la próxima versión de SSL 3.0. La mayoría de las personas están familiarizadas con el término SSL, por lo que suele ser el término que se usa cuando el sistema utiliza el protocolo TLS más reciente.

¿Por qué necesito SSL?

SSL ayuda a evitar que intrusos o compañías intrusivas, como los ISP, manipulen los datos enviados entre sus sitios web y los navegadores de sus usuarios. Es fundamental para proteger la información confidencial, como los números de las tarjetas de crédito, pero también protege su sitio del malware y evita que otros inyecten anuncios en sus recursos. Lea nuestra página de por qué SSL es necesario para obtener más información.

¿Qué es una autoridad de certificación (CA)?

Una autoridad de certificación es una entidad que emite certificados digitales a organizaciones o personas después de validarlos. Las autoridades de certificación deben mantener registros detallados de lo que se ha emitido y de la información utilizada para emitirlo, y se auditan periódicamente para asegurarse de que están siguiendo los procedimientos definidos. Cada autoridad de certificación proporciona una Declaración de Prácticas de Certificación (CPS) que define los procedimientos que se utilizarán para verificar las aplicaciones. Hay muchas CA comerciales que cobran por sus servicios (VeriSign). Las instituciones y los gobiernos pueden tener sus propias CA, y también hay Autoridades de Certificación gratuitas.

Cada autoridad de certificación tiene diferentes productos, precios, características de certificado SSL y niveles de satisfacción del cliente. Obtenga más información sobre cómo elegir un proveedor de certificados o lea nuestras reseñas de certificados SSL para encontrar el mejor proveedor para comprar.

¿Qué es la compatibilidad del navegador?

El certificado que compre para asegurar su sitio web debe estar firmado digitalmente por otro certificado que ya se encuentre en el almacén confiable del navegador web de su usuario. Al hacer esto, el navegador web automáticamente confiará en su certificado porque es emitido por alguien en quien ya confía. Si no está firmado por un certificado raíz de confianza, o si faltan enlaces en la cadena de certificados, entonces el navegador web mostrará un mensaje de advertencia que indica que es posible que el sitio web no sea de confianza.

Por lo tanto, la compatibilidad del navegador significa que el certificado que usted compra está firmado por un certificado raíz que ya es de confianza para la mayoría de los navegadores web que pueden estar usando sus clientes. A menos que se indique lo contrario, los certificados de todos los principales proveedores de certificados que figuran en SSL Shopper son compatibles con el 99% de todos los navegadores. Para obtener más detalles sobre un proveedor de certificados específico, consulte Compatibilidad con certificados SSL.

¿Cuántos nombres de dominio puedo asegurar?

La mayoría de los certificados de servidor SSL solo asegurarán un único nombre de dominio o subdominio. Por ejemplo, un certificado podría asegurar www.youdomain.com o mail.yourdomain.com pero no ambos. El certificado seguirá funcionando con un nombre de dominio diferente, pero el navegador web dará un error cada vez que vea que la dirección en la barra de direcciones no coincide con el nombre de dominio (llamado un nombre común) en el certificado. Si necesita proteger varios subdominios en un solo nombre de dominio, puede comprar un certificado comodín. Para un certificado comodín, un nombre común de * .yourdomain.com aseguraría www.yourdomain.com, mail.yourdomain.com, secure.yourdomain.com, etc ... También hay certificados especiales como Unified Communications (UC) Certificados que pueden asegurar varios nombres de dominio diferentes en un certificado.

¿Qué es un sello de confianza?

Un sello de confianza es un logotipo que puede mostrar en su sitio web y que verifica que un proveedor de certificados en particular lo ha validado y está utilizando su certificado SSL para proteger su sitio. Se puede mostrar en páginas seguras y no seguras y es más apropiado en páginas donde los clientes están por ingresar su información personal, como una página de carrito de la compra, pero se pueden mostrar en cada página para ayudar a generar confianza. El sello de confianza de cada autoridad de certificación es diferente y algunos parecen más profesionales, por lo que debe considerar cómo se ve el sello para maximizar la confianza del cliente. Para obtener más información sobre Trust Seals, lea Gain Trust Online con Trust Seals.


### Objetivos

Para la realización del proyecto ANTI-TYPOSQUATTING, hemos trazado dos tipos de objetivos, que serán los objetivos técnicos y los objetivos basados en el Análisis avanzado de Datos. Ambos objetivos enfocados en la ciberseguridad.

Objetivos Técnicos:

-	Realizar un análisis sobre las posibilidades que posee la mente criminal para utilizar nombres de dominio, para el diseño, desarrollo o adopción de un algoritmo que permite generar variaciones de dominio cercanas a los dominós que un ser humano podría utilizar para realizar Phishing.
-	Identificar los métodos, funciones, productos o servicios que permitan evaluar o extraer información sobre la propiedad de los dominios, la autoridad certificadora y la disponibilidad de estos.
-	Desarrollar un conjunto de funciones que permita integrar el algoritmo desarrollado preliminarmente con las fuentes heterogéneas que puedan realizar la validación de confianza de los dominios de interés.

Objetivos de Análisis de Datos:

-	¿Cuáles serían los márgenes o niveles de riesgo que podrían tener un dominio con sus variaciones?
-	¿Cuáles son las tipificaciones comunes de lo nombres de dominio, existe un patrón común en todas las muestras?
-	¿Puedo deducir que media o promedio de dominios tendría que adquirir para reducir la probabilidad de recibir un ataque de Phishing?


### Adquisición de datos

Tomamos la muestra de un nombre de dominio conocido o de interés para el cual deseamos aplicar el presente proyecto, en este caso será el nombre de dominio que queremos auditar. Para esto y después de un análisis de las diferentes soluciones web que nos permiten tener información completa ,en la mayoría de los casos, hemos seleccionado el sitio https://www.sslshopper.com , este sitio web permite extraer información clave sobre el certificado y el propietario del dominio web, para el presente proyecto será relevante el nombre de la organización propietaria,  ya que será la llave primaria para establecer cuando un nombre de dominio es o no de un propietario de confianza o del mismo propietario dueño del dominio principal en mención. Después de extraer la información relevante sobre el certificado del dominio, se aplicará el algoritmo desarrollado para poder generar variaciones del dominio tal y como lo haría un criminal cibernético.

### Cleansing and transformations

### Data analysis

Para analizar los datos, se han seguido diversas casuísticas para clasificar la información del certificado obtenido de cada dominio. Cada dominio se ha podido clasificar en una de estas maneras:

- Caso # 1

Si el dominio posee certificado y el propietario del dominio generado es igual al propietario del dominio original, se considera riesgo bajo o nulo para un ataque de Phishing de dicho dominio.

- Caso # 2

Si el dominio posee certificado y el propietario del dominio generado es diferente al propietario del dominio original, se considera riesgo bajo, ya que el dominio posee un propietario que es verificable.

- Caso # 3

Si el dominio posee certificado pero no se puede obtener información sobre el propietario de dicho certificado , hacemos uso de otra fuente de validación diferente, a través del sitio web https://www.ultratools.com/tools/ipWhoisLookupResult ,este sitio web nos será de utilidad para validar este tipo de casos, consultamos su IP y si el propietarios de dicha IP es el mimos propietario del dominio original, en este caso se considera riesgo bajo.

- Caso # 4

Si el dominio posee certificado y pero no se puede obtener información sobre el propietario de dicho certificado , hacemos uso de otra fuente de validación diferente, a través del sitio web https://www.ultratools.com/tools/ipWhoisLookupResult ,este sitio web nos será de utilidad para validar este tipo de casos, consultamos su IP y si el propietarios de dicha IP es diferente al propietario del dominio original, en este caso se considera riesgo alto. Ya que este dominio puede ser utilizado con fines fraudulentos.

- Caso # 5

Por ultimo si el dominio no posee certificado y su IP asociada no tiene un propietario se considera de un riesgo muy Alto y cualquier persona podría utilizar dicho dominio para llevar a cabo una Phishing o uno de sus métodos variantes.

### Results / Conclusions.

Tras obtener los datos y clasificarlos según el tipo de dominio, se muestra una gráfica con la que analizar los datos finales. Esta gráfica representa el peligro al que se enfrenta un dominio de ser suplantado por otro parecido.

![alt text](https://github.com/DDS-MCSM/group-assignment-team-07/blob/master/vignettes/Rplot.png)

Como se puede observar en la gráfica anterior, el circulo verde (que contiene los dominios de confianza que pertenecen a la misma organizaion) esta rodeado por 3 círculos de color amarillo, naranja y rojo. El circulo rojo (el mas peligroso) esta formado por los dominios que no tienen ip asociada, por lo que un atacante podría comprar el dominio para suplantar al dominio confiable. El circulo naranja esta formado por los dominios que sí tienen ip asociada pero no tienen certificado. Estos no son tan peligrosos ya que se supone que contienen servicios fiables, y si no, son dominios conocidos por no contener información de interés. Finalmente, el color amarillo esta formado por los dominios parecidos que tienen un certificado valido que no es el del dominio legitimo. Este último no supone demasiado peligro, ya que gracias al certificado se puede validar la autenticidad del sitio.


~~~~
