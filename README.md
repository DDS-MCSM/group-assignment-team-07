# Group Assignment - Data Driven Security

Group Assignment base repository for the Data Driven Security subject of the [CyberSecurity Management Msc](https://www.talent.upc.edu/ing/professionals/presentacio/codi/221101/cybersecurity-management/).

## PROYECTO "ANTI-TYPOSQUATTING" 

El Phishing hoy en día, es uno de los principales riesgos a los que están expuestos los usuarios incautos. Consideremos las altas probabilidades de caer en este tipo de ataques. El Phishing o suplantación de identidad es un método utilizado por los Ciberdelincuentes para engañar a los usuarios y robar información, como por ejemplo números de tarjetas de crédito, contraseñas, cuentas bancarias, en resumen, cualquier información personal o corporativa que pueda ser sensible para cualquier individuo o compañía y cuyo su uso indebido representaría perjuicios económicos o personales serios.

Como bien mencionamos el método Phishing, es un problema grave para los propietarios de dominios, lo que representa un riesgo crítico, para la seguridad de cualquier sitio web y las empresas a menudo pasan por alto el “Phishing” cuando se desarrollan las políticas de seguridad. A pesar de todos estos riesgos muchos propietarios y compañías de dominios no aplican precauciones básicas que puedan proteger su dominio. Por ejemplo, ¿Una empresa que cuenta con un sitio web grande y que genere una alta rentabilidad, que impacto representaría designar un mínimo porcentaje de presupuesto en el Road Map de Seguridad para adquirir los nombres de dominio que tengas una semejanza al dominio principal y que puedan eventualmente ser usados para un ataque de Phishing? La realidad muchas veces no es así, la gente compra un dominio rechazando las protecciones que pueden evitarles dolores de cabeza. 

De esta problemática nace el presente proyecto llamado ANTI-TYPOSQUATTING.


### Requirements

  - Requirement 1
  - Requirement 2
  
  
### Project Description

Description of the project. 

### Goals

### Data acquisition

### Cleansing and transformations

### Data analysis

### Results / Conclusions.


### TO SAVE

~~~~
word=input("digita el dominio: ")
# letters = 'abcdefghijklmnopqrstuvwxyz01'
letters = '4iIl0o1uvbdpq'
splits = [(word[:i], word[i:]) for i in range(len(word) + 1)]
deletes = [L + R[1:] for L, R in splits if R]
transposes = [L + R[1] + R[0] + R[2:] for L, R in splits if len(R)>1]
replaces = [L + c + R[1:] for L, R in splits if R for c in letters]
inserts = [L + c + R for L, R in splits for c in letters]
a = set(deletes + transposes + replaces + inserts)
for e in a :
	print(e + ' , ')
~~~~
