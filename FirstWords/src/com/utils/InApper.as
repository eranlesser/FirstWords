package com.utils
{
//	import com.adobe.ane.productStore.Product;
//	import com.adobe.ane.productStore.ProductEvent;
//	import com.adobe.ane.productStore.ProductStore;
//	import com.adobe.ane.productStore.Transaction;
//	import com.adobe.ane.productStore.TransactionEvent;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.osflash.signals.Signal;

	public class InApper
	{
		//private var productStore:ProductStore;
		public var signal:Signal = new Signal();
		public static const PRODUCT_DETAIL_SUCCESS:String=				"productDetailsSucceeded";
		public static const PRODUCT_DETAIL_FAIL:String=				"productDetailsFail";
		public static const PRODUCT_TRANSACTION_SUCCEEDED:String=		"purchaseTransactionSucceeded";
		public static const PRODUCT_TRANSACTION_FAILED:String=			"purchaseTransactionFailed";
		public static const PRODUCT_RESTORE_SUCCEEDED:String=			"purchaseRestoreSucceeded";
		public function InApper()
		{
			//productStore = new ProductStore();
		}
		
//		public function productDetailsSucceeded(e:ProductEvent):void
//		{
//			trace("in productDetailsSucceeded "+e);
//			var i:uint=0;
//			while(e.products && i < e.products.length)
//			{
//				var p:Product = e.products[i];
//				trace("\nTITLE: " + p.title + "\nDescription: " + p.description + "\nIdentifier : " + p.identifier + "PriceLocale : " + p.priceLocale + "\nPrice: " + p.price);
//				trace("title : "+p.title);
//				trace("description: "+p.description);
//				trace("identifier: "+p.identifier);
//				trace("priceLocale: "+p.priceLocale);
//				trace("price :"+p.price);
//				i++;
//			}
//			//signal.dispatch(PRODUCT_DETAIL_SUCCESS);
//		}
//		
//		public function get purchaseEnabled():Boolean{
//			return productStore.available;
//		}
//		
//		public function productDetailsFailed(e:ProductEvent):void
//		{
//			trace("in productDetailsFailed"+e);
//			var i:uint=0;
//			while(e.invalidIdentifiers && i < e.invalidIdentifiers.length)
//			{
//				trace(e.invalidIdentifiers[i]);
//				i++;
//			}
//			//signal.dispatch(PRODUCT_DETAIL_FAIL);
//		}
//		
//		protected function purchaseTransactionSucceeded(e:TransactionEvent):void
//		{
//			trace("in purchaseTransactionSucceeded" +e);
//			var i:uint=0;
//			var t:Transaction;
//			while(e.transactions && i < e.transactions.length)
//			{
//				t = e.transactions[i];
//				i++;
//				trace("Called Finish on/Finish Transaction " + t.identifier); 
//			}
//			if(e.transactions && e.transactions.length>0){
//				signal.dispatch(PRODUCT_TRANSACTION_SUCCEEDED,e.transactions);
//			}
//			getPendingTransaction(productStore);
//		}
//		
//		protected function purchaseTransactionCanceled(e:TransactionEvent):void{
//			trace("in purchaseTransactionCanceled"+e);
//			var i:uint=0;
//			while(e.transactions && i < e.transactions.length)
//			{
//				var t:Transaction = e.transactions[i];
//				trace(t);
//				i++;
//				trace("FinishTransactions" + t.identifier);
//				productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS, finishTransactionSucceeded);
//				productStore.finishTransaction(t.identifier);
//			}
//			getPendingTransaction(productStore);
//		}
//		
//		protected function purchaseTransactionFailed(e:TransactionEvent):void
//		{
//			trace("in purchaseTransactionFailed"+e);
//			var i:uint=0;
//			while(e.transactions && i < e.transactions.length)
//			{
//				var t:Transaction = e.transactions[i];
//				printTransaction(t);
//				i++;
//				trace("purchaseTransactionFailed " + t.identifier);
//				productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS, finishTransactionSucceeded);
//				productStore.finishTransaction(t.identifier);
//			}
//			signal.dispatch(PRODUCT_TRANSACTION_FAILED,e.transactions);
//			getPendingTransaction(productStore);
//		}
//		
//		public function getPendingTransaction(prdStore:ProductStore):void
//		{
//			trace("pending transaction");
//			var transactions:Vector.<Transaction> = prdStore.pendingTransactions; 
//			var i:uint=0;
//			while(transactions && i<transactions.length)
//			{
//				var t:Transaction = transactions[i];
//				printTransaction(t);
//				i++;
//			}
//		}
//		
//		public function printTransaction(t:Transaction):void
//		{
//			trace("-------------------in Print Transaction----------------------");
//			trace("identifier :"+t.identifier);
//			trace("productIdentifier: "+ t.productIdentifier);
//			trace("productQuantity: "+t.productQuantity);
//			trace("date: "+t.date);
//			trace("receipt: "+t.receipt);
//			trace("error: "+t.error);
//			trace("originalTransaction: "+t.originalTransaction);
//			if(t.originalTransaction)
//				printTransaction(t.originalTransaction);
//			trace("---------end of print transaction----------------------------");
//		}		
//		
//		protected function finishTransactionSucceeded(e:TransactionEvent):void{
//			trace("in finishTransactionSucceeded" +e);
//			var i:uint=0;
//			while(e.transactions && i < e.transactions.length)
//			{
//				var t:Transaction = e.transactions[i];
//				printTransaction(t);
//				i++;
//			}
//		}
//		
//		public function purchase(product:String,quantety:uint):void{
//			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_SUCCESS, purchaseTransactionSucceeded);
//			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_CANCEL, purchaseTransactionCanceled);
//			productStore.addEventListener(TransactionEvent.PURCHASE_TRANSACTION_FAIL, purchaseTransactionFailed);
//			productStore.makePurchaseTransaction(product,quantety);
//		}
//		
//		public function restoreTransactions():void
//		{
//			trace("in restore_Transactions");
//			productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_SUCCESS, restoreTransactionSucceeded);
//			productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_FAIL, restoreTransactionFailed);
//			productStore.addEventListener(TransactionEvent.RESTORE_TRANSACTION_COMPLETE,  restoreTransactionCompleted);
//			productStore.restoreTransactions();
//			
//		}
//		
//		protected function restoreTransactionSucceeded(e:TransactionEvent):void{
//			trace("in restoreTransactionSucceeded" +e);
//			trace("Restore Success");
//			var i:uint=0;
//			while(e.transactions && i < e.transactions.length)
//			{
//				var t:Transaction = e.transactions[i];
//				printTransaction(t);
//				i++;
//				
//				trace("FinishTransactions" + t.identifier);
//				productStore.addEventListener(TransactionEvent.FINISH_TRANSACTION_SUCCESS, finishTransactionSucceeded);
//				productStore.finishTransaction(t.identifier);
//			}
//			if(e.transactions && e.transactions.length>0){
//				signal.dispatch(PRODUCT_RESTORE_SUCCEEDED);
//			}
//			getPendingTransaction(productStore);
//		}
//		
//		protected function restoreTransactionFailed(e:TransactionEvent):void{
//			trace("in restoreTransactionFailed" +e);
//			trace("Restore Fail");
//		}
//		
//		protected function restoreTransactionCompleted(e:TransactionEvent):void{
//			trace("in restoreTransactionCompleted" +e);
//			trace("Restore Complete");
//		}
	}
}