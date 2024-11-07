package mongo_jdbc_connectivity;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

public class Main {
	
	public static void createCollection(MongoDatabase db) {
		
		db.createCollection("users");
		System.out.println("Collection Created successfuly");
	}
	
	public static void insertOneDoc(MongoDatabase db) {
		MongoCollection<Document> mongoCollection = db.getCollection("users");
		
		Document newDoc = new Document();
		newDoc.append("name", "Amey Kulkarni");
		newDoc.append("price", 20000);
		newDoc.append("gender", "Male");
		
		mongoCollection.insertOne(newDoc);
		
		System.out.println("Docment Inserted successfuly");
	}
	
	public static void insertManyDocs(MongoDatabase db) {
		List<Document> newDocs = new ArrayList<Document>();
		MongoCollection<Document> mongoCollection = db.getCollection("users");
		
		int[] prices = {10000, 35000, 56000};
		String[] names = {"Tirthraj Mahajan", "Advait Joshi", "Suvrat Ketkar"};
		
		for(int i=0; i<names.length; i++) {
			Document newDoc = new Document();
			
			newDoc.append("name", names[i]);
			newDoc.append("price", prices[i]);
			newDoc.append("gender", "Male");
			
			newDocs.add(newDoc);
		}
		
		mongoCollection.insertMany(newDocs);
		
		System.out.println("Docments Inserted successfuly");
		
	}
	
	public static void readAllDocs(MongoDatabase db)
	{
		MongoCollection<Document> mongoCollection = db.getCollection("users");
		
		MongoCursor<Document> mongoCursor =  mongoCollection.find().cursor();
		
		while(mongoCursor.hasNext())
		{
			Document doc = mongoCursor.next();
			ObjectId id = doc.getObjectId("_id");
			String name = doc.getString("name");
			int price = doc.getInteger("price");
			String gender = doc.getString("gender");
			
			System.out.println("\n__________________________");
			System.out.println("id : "+id);
			System.out.println("name : "+name);
			System.out.println("price : "+price);
			System.out.println("gender : "+gender);
		}
	}
	public static void updateOneDoc(MongoDatabase db) {
		MongoCollection<Document> mongoCollection = db.getCollection("users");
		
		mongoCollection.updateOne(Filters.eq("name", "Amey Kulkarni"), Updates.combine(Updates.set("name", "Amey")));
		System.out.println("Updated Docs");
	}
	
	public static void deleteDoc(MongoDatabase db) {
		MongoCollection<Document> mongoCollection = db.getCollection("users");
		
		mongoCollection.deleteOne(Filters.eq("name", "Amey Kulkarni"));
		System.out.println("Deleted Doc");
	}
	
	public static void main(String args[]){
		
		Scanner sc = new Scanner(System.in);
		
		try {
			
			MongoClient mongo = null;
			MongoDatabase db = null;
			
			mongo = new MongoClient("localhost", 27017);
			db = mongo.getDatabase("mongo_connectivity");
			
			deleteDoc(db);
			
			mongo.close();
		}
		catch(Exception e)
		{
			System.out.println(e.getStackTrace());
		}
		
		
	}
		
}
