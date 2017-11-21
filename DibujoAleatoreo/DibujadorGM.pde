class DibujadorGM{

  private ArrayList<PImage> images ;
  private ArrayList<Position> espacios;
  DibujadorGM(){
    images = new ArrayList<PImage>();
    espacios = new ArrayList<Position>();
  }
  public ArrayList<PImage> getImages(){
    return this.images;
  }
  public ArrayList<Position> getEspacios(){
    return this.espacios;
  }
  public  void listFilesForFolder(final File folder) {
    for (final File fileEntry : folder.listFiles()) {
        if (fileEntry.isDirectory() && !fileEntry.getName().contains(".DS_Store")) {
            listFilesForFolder(fileEntry);
        } else {
          System.out.println(fileEntry.getAbsolutePath());
          if(!fileEntry.getName().contains(".DS_Store")){
            images.add(loadImage(fileEntry.getAbsolutePath()));
          }
        }
    }
  }
  public void initEspacios(int w, int h){
      for(int i = 0; i< w; i++){
        for(int j = 0;j<h;j++){
            espacios.add(new Position(i,j));
        }
      }
  }
  public void deletePos(int x, int y){
      for(int i=0;i<espacios.size();i++){
          if(espacios.get(i).x == x && espacios.get(i).y == y){
            espacios.remove(i);
            break;
          }
      }  
  }
  public Position getRandom(){
    if(espacios.size()!= 0){
      int pos = (int)random(espacios.size());
      return espacios.remove(pos);
    }
    return new Position(-1,-1);
  }
}