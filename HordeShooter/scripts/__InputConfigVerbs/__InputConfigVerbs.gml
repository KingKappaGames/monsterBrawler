function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
		LEFTCLICK,
		RIGHTCLICK,
		MIDDLECLICK,
		JUMP,
        ACCEPT,
        CANCEL,
        ACTION,
        MAGIC,
		SPECIAL,
		BURST,
        PAUSE,
		CAMERAZOOMIN,
		CAMERAZOOMOUT,
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    if (not INPUT_ON_SWITCH) {
        InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
		InputDefineVerb(INPUT_VERB.LEFTCLICK,   "leftClick",      [mb_left],          [ gp_shoulderrb]);
		InputDefineVerb(INPUT_VERB.RIGHTCLICK,   "rightClick",      [mb_right],          [ gp_shoulderlb]);
		InputDefineVerb(INPUT_VERB.MIDDLECLICK,   "middleClick",      [mb_middle],          [ gp_shoulderr ]); // controller middle click no make sense yo (it's on right bumber for now)
        InputDefineVerb(INPUT_VERB.JUMP,  "jump",      vk_space,            gp_face1);
        InputDefineVerb(INPUT_VERB.ACCEPT,  "accept",      "E",            gp_face1);
        InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",      vk_backspace,        gp_face2);
        InputDefineVerb(INPUT_VERB.ACTION,  "action",      vk_enter,            gp_face3);
        InputDefineVerb(INPUT_VERB.MAGIC, "magic",     vk_shift,            gp_face4);
        InputDefineVerb(INPUT_VERB.SPECIAL, "special",     "C",            gp_face4); // gp ?
        InputDefineVerb(INPUT_VERB.BURST, "burst",     vk_control,            gp_face4); // gp ?
        InputDefineVerb(INPUT_VERB.PAUSE,   "pause",       vk_escape,           gp_start);
        InputDefineVerb(INPUT_VERB.CAMERAZOOMIN,   "cameraZoomIn",       vk_add,           gp_padu);
        InputDefineVerb(INPUT_VERB.CAMERAZOOMOUT,   "cameraZoomOut",       vk_subtract,           gp_padd);
    }
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}
