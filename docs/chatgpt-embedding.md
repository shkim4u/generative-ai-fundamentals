# 1. Creating a vector database using ```SingleStore```
1. Create an account in ```SingleStore``` and get onboard onto it, which is a vector database service provider.<br>
     * [SingleStore](https://www.singlestore.com/): Real-time Unified Distributed SQL and Built-in Vector Database
     * [SingleStore Built-in Vector Database](https://www.singlestore.com/built-in-vector-database/)<br>
       * ![Diagram Contextual Data as Vector](../resources/images/diagram_contextual-data-as-vectorsNEW.png)
     * Can utilize storage provided by cloud service providers, including AWS S3.
       * ![SingleStore Data Storage by Cloud Service Provider](../resources/images/SingleStore-Cloud-Storage-Options.png)
     * Choose AWS as cloud provider.
       * ![AWS as Cloud Provider](../resources/images/SingleStore-Onboarding-AWS-with-Region.png)
       * Workspace Group Name: ```OpenAI Vector Database Workspace```
       * ![Workspace Detials](../resources/images/SingleStore-Onboarding-AWS-with-Region-Workspace-Detials.png)
     * SingleStore onboarding and creeating workspace completed.
       * ![SingleStore Onboarded](../resources/images/SingleStore-Onboarded-AWS.png)

2. Create a vector database and a table.<br>
   * Create a vector database.<br>
     * ![](../resources/images/Create-Vector-Database.png)<br>
     * Database Name: ```openai_database```
     * ![](../resources/images/Create-Vector-Database-OpenAI.png)<br>
     * ![](../resources/images/Select-Created-Vector-Database-OpenAI.png)
   * Create a table.<br>
     * Select ```SQL Editor```.<br>
       * ![](../resources/images/Create-Table-Editor.png)
     * Create a table with the DDL statement below.<br>
		```sql
		CREATE TABLE IF NOT EXISTS vectortable (
			text TEXT,
			vector BLOB
		);
		```

		 * ![](../resources/images/Run-Create-Table-Statement.png)<br>
		 * You can see the generated table as shown below.<br>
  		 * ![](../resources/images/Created-Vector-Table.png)

3. We will insert some data with texts and corresponing embeddings in vector space generated with OpenAI API that explained in the following sections.

# 2. Embeddings using OpenAI API<br>
1. Create an embeddings for initial input (```Hello World```) on OpenAI API.
```bash
# (Note) OPENAI_API_KEY should be defined in environment variable.
curl https://api.openai.com/v1/embeddings \
	-H "Content-Type: application/json" \
	-H "Authorization: Bearer $OPENAI_API_KEY" \
	-d '{
		"input": "Hello World",
		"model": "text-embedding-ada-002"
	}'
```

혹은 ```Postman```과 같은 도구를 사용할 수 있습니다.<br>
![OpenAI Embeddings using Postman](../resources/images/Generate-OpenAI-Embeddings-Postman.png)

> (참고) t-SNE (t-Distributed Stochastic Neighbor Embeddings)<br>
> t-SNE, which stands for t-distributed stochastic neighbor embedding, is a machine learning algorithm used for visualizing high-dimensional data in a lower-dimensional space, typically two or three dimensions. It is particularly useful for visualizing how data points are clustered and for revealing patterns that may not be apparent in higher dimensions.<br><br>
The algorithm works by measuring the similarity between data points in high-dimensional space and representing these similarities as probabilities. It then seeks to minimize the difference between these probabilities in the high-dimensional space and the lower-dimensional space, effectively mapping the data points to their new lower-dimensional positions in such a way that similar data points remain close to each other.<br><br>
t-SNE is commonly used in exploratory data analysis, dimensionality reduction, and visualization of complex datasets, particularly in fields such as machine learning, bioinformatics, and natural language processing. It is worth noting that while t-SNE can provide valuable insights into the underlying structure of data, its results should be interpreted with care and in combination with other analytical techniques due to its sensitivity to different parameter settings.<br><br>
In summary, t-SNE is a powerful tool for visualizing high-dimensional data and understanding the inherent structure of the data, allowing for effective exploratory analysis and insights into complex datasets.  

Take note the response data (JSON array) and insert that value with the original text into the vector table.<br>

* Postman 실행 결과로부터 Embedding 값 복사<br>
![Postman Copy Embedding Value](../resources/images/Copy-Embedding-Postman.png)

* SingleStore SQL Editor에서 텍스트 값과 임베딩을 Insert<br>
 ```sql
     INSERT INTO vectortable (text, vector) VALUES ("Hello World", JSON_ARRAY_PACK("[
             -0.0070839436,
             0.003516513,
             -0.0070712143,
             ... -- Deleted for brevity.
     ]"));
 ```
 <br>

 ![SingleStore SQL Editor Embedding Hello World](../resources/images/Insert-Embedding-Value-Hello-World.png)<br>

* 벡터 테이블에 Insert된 값<br>
 ![Inserted Embedding Hello World](../resources/images/Inserted-Embedding-Value-Hello-World-Vector-Table.png)


2. Then, create more embeddings with complex inputs using OpenAI API.
* ```OpenAI Embeddings and Vectorize is made easy!```<br>
```bash
curl --location 'https://api.openai.com/v1/embeddings' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer $OPENAI_API_KEY' \
--data '{
    "input": "OpenAI Embeddings and Vectorize is made easy!",
    "model": "text-embedding-ada-002"
}'
```

![Postman OpenAI Embedding Made Easy](../resources/images/Postman-OpenAI-Embedding-Made-Easy.png)<br>
![OpenAI Made Easy](../resources/images/Insert-OpenAI-Made-Easy-Embedding.png)<br>
![Emedding Row OpenAI Made Easy](../resources/images/Embedding-Row-OpenAI-Made-Easy.png)<br>


* Sample Contract Text<br>
```bash
curl --location 'https://api.openai.com/v1/embeddings' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer $OPENAI_API_KEY' \
--data '{
    "input": "Contractor will submit invoices to Mercy Corps in accordance with the invoicing schedule and invoicing delivery terms set forth in the Statement of Services (Schedule I). Final invoices must be submitted within 60 days of the end date of the Contract. Contractor recognizes that in many cases Mercy Corps’ donor will not reimburse Mercy Corps for invoices submitted beyond 60 days after the termination of a contract and therefore Mercy Corps will have no obligation to pay any portion of invoices received more than 60 days after the end date of the Contract. Each invoice will include (i) the Contract Number; (ii) Contractor’s name and address; (iii) a description of the Services performed, (iv) the dates such Services were performed, (v) a pricing calculation based on the payment terms, (vi) properly reimbursable expenses (if any) incurred along with receipts for such expenses (if applicable) for all individual expenses exceeding $25 USD, and (vii) such other information as Mercy Corps may reasonably request.  Invoices will only be deemed received on the date they are delivered to the Authorized Representative pursuant to the Payment Terms (see Schedule I).  If Mercy Corps determines that Services that are the subject of an invoice have not been performed in accordance with the Statement of Services, Mercy Corps may dispute the invoice by sending Contractor notice of such dispute after Mercy Corps’ receipt of the invoice. Such notice shall clearly state the specific Services disputed, and Mercy Corps’ reason for disputing the performance of the Services. If both parties accept the dispute of the invoice, they shall agree in writing as to the steps required of Contractor to ensure that the performance of the disputed Services is subsequently completed in accordance with the Additional Terms, and the time required of Contractor to complete the Services.",
    "model": "text-embedding-ada-002"
}'
```

![Postman Contract Text](../resources/images/Postman-Contract-Text-Embedding.png)<br>
![OpenAI Contract Text](../resources/images/Insert-contract-Text-Embedding.png)<br>
![Embedding Row Contract Text](../resources/images/Embedding-Row-Contract-Text.png)<br>

# 3. Searching Embeddings<br>
1. Create an embedding to search.<br>
   * Word to serch: ```OpenAI```<br>
   * Using ```curl``` command 
       ```bash
       curl --location 'https://api.openai.com/v1/embeddings' \
        --header 'Content-Type: application/json' \
        --header 'Authorization: Bearer $OPENAI_API_KEY' \
        --data '{
            "input": "OpenAI",
            "model": "text-embedding-ada-002"
        }'
       ```
   * Using ```Postman```<br>
        ![Postman OpenAI Embedding Search](../resources/images/Create-Embedding-Search-Word-OpenAI.png)<br>
   * Copy the embedding from response to clipboard to search in next steps.<br>

2. Search the embedding in the vector database.<br>
   * Find the text of which corresponding vector (embedding) has the biggest rank calculated by DOT_PRODUCT function.<br> 
     ```sql
     SELECT text, DOT_PRODUCT(vector, JSON_ARRAY_PACK("[
         -0.011825546,
         -0.014264866,
         -0.010375697,
         ... -- Deleted for brevity.
     ]")) AS score
     FROM vectortable
     ORDER BY score DESC
     LIMIT 10;
     ```
    * As you can see below, the text with the biggest score is ```OpenAI Embeddings and Vectorize is made easy!```.<br>
      ![Search Embedding OpenAI](../resources/images/Select-Neighbor-Text-With-Highest-Similarities.png)<br>  

# 4. References

[//]: # (1. YouTube Contents)

[//]: # (	- [YouTube Channel]&#40;https://www.youtube.com/watch?v=ySus5ZS0b94&ab_channel=AdrianTwarog&#41;)

1. OpenAI
	- [OpenAI Blog Post on API](https://openai.com/blog/openai-api/)
	- [OpenAI Embeddings](https://platform.openai.com/docs/guides/embeddings/what-are-embeddings)
