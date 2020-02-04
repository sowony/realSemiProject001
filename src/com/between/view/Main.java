package com.between.view;
//This sample uses Apache HttpComponents:
//Apache에서 제공하고 있는 HttpClient 라이브러리를 이용해 REST API를 호출하는 방법을 사용할거같음

//http://hc.apache.org/httpcomponents-core-ga/httpcore/apidocs/
//https://hc.apache.org/httpcomponents-client-ga/httpclient/apidocs/

import java.net.URI;                        //for api입니다.
import org.apache.http.HttpEntity;               //for api입니다.
import org.apache.http.HttpResponse;            //for api입니다.
import org.apache.http.client.HttpClient;         //for api입니다.
import org.apache.http.client.methods.HttpPost;      //for api입니다.
import org.apache.http.entity.StringEntity;         //for api입니다.
import org.apache.http.client.utils.URIBuilder;      //for api입니다.
import org.apache.http.impl.client.HttpClientBuilder;   //for api입니다.
import org.apache.http.util.EntityUtils;         //for api입니다.

//Main클래스를 다음 코드로 바꿉니다. 이 데이터는 Face데이터에 연결하는 방법과
//입력데이터를 가져올 위치를 지정합니다.
public class Main {
   // Replace <Subscription Key> with your valid subscription key.
   private static final String subscriptionKey = "0317fc9c56a84b8b89d4ffea7ceff3c5";
//엔드포인트
   private static final String uriBase = "https://westcentralus.api.cognitive.microsoft.com/face/v1.0/detect";

   //private static final String imageWithFaces = "{\"url\":\"https://upload.wikimedia.org/wikipedia/commons/c/c3/RH_Louise_Lillian_Gish.jpg\"}";
   private static  String imageWithFaces = "";
   //faceAttributes 필드는 단순히 특정 유형의 특성 목록입니다. 감지된 얼굴에 대해 검색할 정보를 지정합니다.
   private static final String faceAttributes = "age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise";

   public String sendData() {
      HttpClient httpclient = HttpClientBuilder.create().build();
      System.out.println("httpclient Main Start --------------------");
      System.out.println(httpclient); //org.apache.http.impl.client.InternalHttpClient@2c9f9fb0 호출
      try {
         //URIBuilder : URI를 생성하기 위한 일종의 유틸리티 클래스 <<- URI형식에 맞게 데이터 생성하기 위해 사용
         URIBuilder builder = new URIBuilder(uriBase); 
                                             
/* URIBuilder에서 제공하는 메서드
  .addParameter(String param, String value) : URI매개변수 추가
  .setParameter(String param, String value) : 〃 + 중복된 매개변수가 있다면 그 값을 다시 덮어쓴다.
  .build() : URIBuilder 객체에 설정된 설정값을 이용하여 새로운 URI객체를 생성
 
 */

/* Apache HttpComponents에서 제공하는 클래스
 * ##내부적으로 HTTP통신에 있어 성능 개선을 위해 POOL기술을 사용하고 있다.
    
   HttpPost : 서버 사이드에서 특정 URI로 통신하는 것.
    
   HttpEntity : 
 */
         
 /*
  * (http구동 정리, https://inyl.github.io/programming/2017/09/14/http_component.html)
  * HttpClient -> HttpComponent >> HttpClient가 기존과 다르게 작은 모듈과 같은 개념으로 재사용 가능하게됨. 의미
  * build method를 보면
  *   내부에서 PoolingHttpClientConnectonManager를 생성하는 것을 확인 가능
  *    >> HttpComponent의 default connection manager는 Connection Pool로 이뤄진 것을 확인 가능.
    ...
    정리하면 HttpComponent를 쓸 때는
    -http client 계속 생성하지 말자
    -client는 multi thread에서 같이 써도 괜찮다.
    -오픈소스 사용 시엔 문서와 소스코드를 잘 살펴보자.
    
  */

         // Request parameters. All of them are optional.
         builder.setParameter("returnFaceId", "true");
         builder.setParameter("returnFaceLandmarks", "false");
         builder.setParameter("returnFaceAttributes", faceAttributes);

         // Prepare the URI for the REST API call.
         URI uri = builder.build();   //새로운 URI객체 생성해서 uri에 담음
         HttpPost request01 = new HttpPost(uri); //서버 사이드에서 특정 URI로 통신하는 것

         // Request headers.
         request01.setHeader("Content-Type", "application/json");   // ? 데이터 형식 얘기하는건가...?
         request01.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey); // 
         
         
      
         
      //   Gson json = new Gson();
      //   String jsonPath = json.toJson(imageWithFaces);
      //   System.out.println(imageWithFaces+"json으로 바꾸기 전 모델입니다.");
      //   System.out.println(jsonPath+"json으로 바꿨읍니다.");

         // Request body.
         StringEntity reqEntity = new StringEntity(imageWithFaces); //이미지를 문자열DB? json형태의 Stringvalue? 여기서 담기는건가
         request01.setEntity(reqEntity);
         
         // Execute the REST API call and get the response entity.
         HttpResponse response = httpclient.execute(request01);
         HttpEntity entity = response.getEntity();
//   System.out.println(entity);   //entity는 proxy정보?를 줌
//   System.out.println("============================");
         
         if (entity != null) {
            // Format and display the JSON response.
            System.out.println("REST Response:\n");

            String jsonString = EntityUtils.toString(entity).trim();
            System.out.println(jsonString);   //니가 json값이다!!!!
            System.out.println("=================gkgkgk===========");
            
            
            
            String [] readyToCutData01 = jsonString.split(":");
            
            for(int i= 0; i<readyToCutData01.length; i++){
         //   if(readyToCutData01[i].contains(",")) {
               String [] readyToCutData02 = readyToCutData01[i].split(",");
                     
               System.out.println(readyToCutData02);
         //      System.out.println(readyToCutData01);
            
         //   }
            }
            System.out.println("이제 넘어갑니다.");
            return jsonString; //문자열
            
//            if (jsonString.charAt(0) == '[') {
//               JSONArray jsonArray = new JSONArray(jsonString);
//               System.out.println(jsonArray.toString(2));
//            } else if (jsonString.charAt(0) == '{') {
//               JSONObject jsonObject = new JSONObject(jsonString);
//               System.out.println(jsonObject.toString(2));
//            } else {
//               System.out.println(jsonString);
//            }
         }else {
            return null;
         }
      } catch (Exception e) {
         // Display error message.
         System.out.println(e.getMessage());
         return null;
      }
   }
   public void setPath(Object file2) {
      imageWithFaces = "{\"url\":\""+file2+"\"}";
   }
   public String getPath() {
      return imageWithFaces;
   }

}