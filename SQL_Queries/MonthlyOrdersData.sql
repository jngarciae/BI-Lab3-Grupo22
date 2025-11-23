WITH OrderTotals AS (
  SELECT
    f.OrderID,
    d.Year,
    d.Month,
    SUM(f.TotalPrice) AS OrderTotal
  FROM
    `lab3-bi-20252.lab3_bi_conjunto.FactTableOrderLines` AS f
  JOIN
    `lab3-bi-20252.lab3_bi_conjunto.DimDates` AS d
  ON
    f.DateID = d.DateID
  WHERE
    d.Year = 2014
  GROUP BY
    f.OrderID,
    d.Year,
    d.Month
)
SELECT
  Year,
  Month,
  COUNT(*)        AS OrdersCount,
  AVG(OrderTotal) AS AvgOrderValue,
  SUM(OrderTotal) AS TotalSales
FROM
  OrderTotals
GROUP BY
  Year,
  Month
ORDER BY
  Year,
  Month;
