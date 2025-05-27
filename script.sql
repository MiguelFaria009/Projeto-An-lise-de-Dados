
WITH VISAPERFIL AS (
    SELECT 
        i.pdate,
        i.OrderId,
        i.LineItemId, 
        i.City, 
        i.DeviceCategory,
        i.CreativeSize,
        IFNULL(
            (SELECT u.value FROM UNNEST(i.GloboMetadata.key_value) u WHERE u.key = 'ambient'),
            "N/A"
        ) AS ambient,
        (
            SELECT value 
            FROM UNNEST(i.ognCluster.key_value) 
            WHERE key = 'ogncluster'
        ) AS krux,
        CONCAT(i.TimeUsec2, i.KeyPart) AS impression,
        (
            SELECT COUNT(*)
            FROM `projeto.dataset.admanager_prepclicks` c
            WHERE 
                c.pdate = i.pdate AND 
                c.OrderId = i.OrderId AND
                CONCAT(c.TimeUsec2, c.KeyPart) = CONCAT(i.TimeUsec2, i.KeyPart)
        ) AS clicks
    FROM 
        `projeto.dataset.admanager_prepimpressions` i
    ORDER BY 
        clicks DESC
),

TABELA_PERFIL AS (
    SELECT 
        pdate,
        OrderId,
        LineItemId,
        City,
        DeviceCategory,
        CreativeSize,
        ambient,
        impression,
        clicks,
        element AS krux_id
    FROM 
        VISAPERFIL
    CROSS JOIN 
        UNNEST(SPLIT(krux)) AS element
)

SELECT 
    p.*, 
    k.*
FROM 
    TABELA_PERFIL p
LEFT JOIN 
    `projeto.dataset.tabela_krux` k
ON 
    p.krux_id = k.ID
WHERE 
    p.OrderId IN (123456789);
