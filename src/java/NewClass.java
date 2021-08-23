/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author MARCOS
 */
public class NewClass {
    public static void main(String []args){
        for(int i=0;i<5; i++){
           
            
            for(int j=0;j<=i;j++){
                if(i%2 == 0){
                    if(j%2 == 0){
                      System.out.print(1);   
                    }else{
                        System.out.print(0);
                    }
                    
                   
                }else{
                    if(j%2 == 0){
                        System.out.print(0);
                    }else{
                        System.out.print(1);
                    }
                    
                }
            }
            System.out.println();
        }
    }
    
}
