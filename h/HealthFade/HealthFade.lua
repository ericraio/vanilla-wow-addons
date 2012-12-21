local HealthFadeHook;
function HealthFade()
   HealthFadeHook=HealthBar_OnValueChanged;
   HealthBar_OnValueChanged=HealthFade_Smooth;
end

function HealthFade_Smooth(value, smooth)
  HealthFadeHook(value, 1); --sets smooth to true
end
		
