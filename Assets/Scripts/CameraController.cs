using UnityEngine;

namespace Learn.Ryuu.BuiltIn.Shader
{
    [ExecuteAlways]
    public class ColoredCameraController : MonoBehaviour
    {
        [SerializeField] private Material material;

        private void OnRenderImage(RenderTexture source, RenderTexture destination)
        {
            Graphics.Blit(source, destination, material);
        }
    }
}