class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super();
    setPosition(x, y);
    setName("bridge");
    setStatic(true);
    attachImage(bridgec);
  }


  void act() {
    if (isTouching("player")) {
      setStatic(false);
      setSensor(true);
     
    }
  }
}
