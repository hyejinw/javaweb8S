package com.spring.javaweb8S.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb8S.dao.AdminDAO;
import com.spring.javaweb8S.vo.BookVO;

@Service
public class BookInsertSearch {

	@Autowired
	AdminDAO adminDAO;

  public ArrayList<BookVO> bookInsert(String query) throws UnsupportedEncodingException {

  	ArrayList<BookVO> vos = new ArrayList<BookVO>();

		String encodedQuery = URLEncoder.encode(query, "UTF-8");
		String apiUrl = "https://dapi.kakao.com/v3/search/book?target=title&query=" + encodedQuery;

	  String apiKey = "7687511cd3463867077e445e82c52e7a";

	  try {
      URL url = new URL(apiUrl);
      HttpURLConnection connection = (HttpURLConnection) url.openConnection();
      connection.setRequestMethod("GET");
      connection.setRequestProperty("Authorization", "KakaoAK " + apiKey);

      BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
      String line;
      StringBuilder response = new StringBuilder();

      while ((line = reader.readLine()) != null) {
        response.append(line);
      }

      reader.close();
      connection.disconnect();

      JSONParser parser = new JSONParser();

      JSONObject obj = (JSONObject) parser.parse(response.toString());
      String data = obj.get("documents").toString();
      JSONArray resultArray = (JSONArray) parser.parse(data);


      for (Object element : resultArray) {
      	BookVO vo = new BookVO();
      	JSONObject book = (JSONObject) element;

      	// 작가와 번역자는 array 처리
      	// 1) 작가
      	String authorsStr = book.get("authors").toString();
      	JSONArray authorsArray = (JSONArray) parser.parse(authorsStr);
      	String authors = "";

      	if(authorsArray.size() != 0) {
	      	for (Object element2 : authorsArray) {
	      	  authors += element2.toString() + "/";
	      	}
	      	authors = authors.substring(0, authors.lastIndexOf("/"));
      	}
      	
      	// 2) 번역자
      	String translatorsStr = book.get("translators").toString();
      	JSONArray translatorsArray = (JSONArray) parser.parse(translatorsStr);
      	String translators = "";

      	if(translatorsArray.size() != 0) {
      		for (Object element2 : translatorsArray) {
      			translators += element2.toString() + "/";
      		}
      		translators = translators.substring(0, translators.lastIndexOf("/"));
      	}

      	vo.setTitle(book.get("title").toString());
      	vo.setContents(book.get("contents").toString());
      	vo.setUrl(book.get("url").toString());
      	vo.setIsbn(book.get("isbn").toString().replace(" ", "/"));
      	vo.setDatetime(book.get("datetime").toString().substring(0,19).replace("T", " "));
      	vo.setAuthors(authors);
      	vo.setPublisher(book.get("publisher").toString());
      	vo.setTranslators(translators);
      	vo.setPrice(Integer.parseInt(book.get("price").toString()));
      	vo.setSale_price(Integer.parseInt(book.get("sale_price").toString()));
      	vo.setThumbnail(book.get("thumbnail").toString());
      	vo.setStatus(book.get("status").toString());

      	if((adminDAO.getBookIsbn(vo.getIsbn()) == null)) adminDAO.setBook(vo);

      	vos.add(vo);
      }

    } catch (IOException e) {
        e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}

	  return vos;
  }
}
