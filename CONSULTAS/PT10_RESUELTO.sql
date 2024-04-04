# EJ1 ¿MUESTRA UNA LISTA CON LAS MARCAS DE LOS VEHÍCULOS Y LA CANTIDAD DE SINIESTROS QUE HA SUFRIDO CADA MARCA?

SELECT
	V.MARCA,
    COUNT(*) AS SINIESTROS
FROM SINIESTRO S
JOIN POLIZA P ON S.NUMERO_POLIZA=P.NUMERO_POLIZA
JOIN CLIENTE_ASEGURA_VEHICULO VAC ON P.ID_VEHICULO_ASEGURADO=VAC.ID
JOIN VEHICULO V ON VAC.NUMERO_BASTIDOR_VEHICULO=V.NUMERO_BASTIDOR
GROUP BY V.MARCA;

# EJ2 MUESTRA EL NOMBRE DE LOS 5 CLIENTES QUE MÁS PAGAN POR LAS COBERTURAS.

SELECT 
	CLI.NOMBRE,
    SUM(COB.CUANTIA) AS PAGOS
FROM CLIENTE CLI
JOIN CLIENTE_ASEGURA_VEHICULO VAC ON CLI.DNI=VAC.DNI_CLIENTE
JOIN POLIZA P ON P.ID_VEHICULO_ASEGURADO=VAC.ID
JOIN POLIZA_ASOCIA_COBERTURA PAC ON P.NUMERO_POLIZA=PAC.NUMERO_POLIZA
JOIN COBERTURA COB ON PAC.CODIGO_COBERTURA=COB.CODIGO
GROUP BY CLI.DNI
ORDER BY PAGOS DESC
LIMIT 5;

# EJ3 MUESTRA EL NOMBRE DEL CLIENTE CUYOS SINIESTROS ACUMULAN LA MAYOR CUANTÍA.

SELECT 
	CLI.NOMBRE,
    SUM(S.CUANTIA) AS CUANTIA_SINIESTROS
FROM CLIENTE CLI
JOIN CLIENTE_ASEGURA_VEHICULO VAC ON CLI.DNI=VAC.DNI_CLIENTE
JOIN POLIZA P ON P.ID_VEHICULO_ASEGURADO=VAC.ID
JOIN SINIESTRO S ON S.NUMERO_POLIZA=P.NUMERO_POLIZA
GROUP BY CLI.DNI
ORDER BY CUANTIA_SINIESTROS DESC
LIMIT 1;

# EJ4 MUESTRA LOS COLORES DE LOS VEHÍCULOS Y CUÁNTO PAGAN DE MEDIA POR SUS COBERTURAS.

SELECT 
	V.COLOR,
    AVG(COB.CUANTIA) AS CUANTIAS_MEDIAS
FROM VEHICULO V
JOIN CLIENTE_ASEGURA_VEHICULO VAC ON VAC.NUMERO_BASTIDOR_VEHICULO=V.NUMERO_BASTIDOR
JOIN POLIZA P ON P.ID_VEHICULO_ASEGURADO=VAC.ID
JOIN POLIZA_ASOCIA_COBERTURA PAC ON P.NUMERO_POLIZA=PAC.NUMERO_POLIZA
JOIN COBERTURA COB ON PAC.CODIGO_COBERTURA=COB.CODIGO
GROUP BY V.COLOR;